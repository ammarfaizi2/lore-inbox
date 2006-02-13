Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWBMDwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWBMDwd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 22:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWBMDwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 22:52:33 -0500
Received: from hera.kernel.org ([140.211.167.34]:57814 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750731AbWBMDwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 22:52:32 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: nfsroot doesn't work with intel card since 2.6.12.2/2.6.11
Date: Sun, 12 Feb 2006 19:52:04 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dsovp4$bqt$1@terminus.zytor.com>
References: <20060205215455.7622B1C8E46@fisica.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1139802724 12126 127.0.0.1 (13 Feb 2006 03:52:04 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 13 Feb 2006 03:52:04 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060205215455.7622B1C8E46@fisica.ufpr.br>
By author:    carlos@fisica.ufpr.br (Carlos Carvalho)
In newsgroup: linux.dev.kernel
>
> We have several machines with Intel Corp. 82544EI Gigabit Ethernet
> Controller (Copper) (rev 02), as reported by lspci. They don't manage
> to mount the rootfs via nfs anymore. I've tried several combinations
> and the last one that works is 2.6.12.2 using the 2.6.11 version of
> the driver (simply replacing the files in the tree). 2.6.12.2 with its
> own driver doesn't work.
> 
> There seems to be a pattern: at each version the machine has more
> difficulty mounting the rootfs. Other machines using other ethercards
> but with the same server and filesystem work normally.
> 

Care to try out the klibc tree?

git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git

	-hpa
