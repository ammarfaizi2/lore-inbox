Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUCIMSt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 07:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUCIMSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 07:18:49 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:30109 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261897AbUCIMSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 07:18:47 -0500
Date: Tue, 09 Mar 2004 20:18:02 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Timothy Miller" <miller@techsource.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: HELP: Linux replacement for "DOS diagnostic" station
References: <404CFF03.1090601@techsource.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4lggckj4evsfm@smtp.pacific.net.th>
In-Reply-To: <404CFF03.1090601@techsource.com>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some general suggestions on how to "begin" migrating DOS to
linux using an incremental approach.

My requirements were similar albeit for embedded apps, was/am using DOS
based  development tools.

First get _your_ DOS version running on linux using DOSEMU. DOSEMU can
run _any_ version of DOS. I use it with PCDOS 6.3.

To control DOS from linux (bat->sh), consider a remote shell for dos.

As to PCI and your old tools, you could boot linux with pci=off, so it
won't touch PCI, then map PCI IO into DOSEMU.

Next, suggest tools to port first to linux where upgrade is suggested.

You could modify the PCI driver to exclude device id's but those in a list
- may be a nice patch for general use too :)

Regards
Michael
