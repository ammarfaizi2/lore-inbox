Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTKIMK1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 07:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbTKIMK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 07:10:27 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:45828 "EHLO
	cygnus-ext.enyo.de") by vger.kernel.org with ESMTP id S262429AbTKIMKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 07:10:24 -0500
Date: Sun, 9 Nov 2003 14:10:18 +0100
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ?
Message-ID: <20031109131018.GA18342@deneb.enyo.de>
References: <1067411342.1574.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067411342.1574.11.camel@localhost>
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg wrote:

> losetup -e blowfish /dev/loop0 /file
> Password:
> mkfs -t ext3 /dev/loop0
> mount /dev/loop0 /mnt
> <error unknown fs type>
> <from here something was seriously broken... could not reboot anymore>

I'm seeing something similar, but in my case, mke2fs already crashes.

> system is:
> Linux no 2.6.0-test7 #8 Sun Oct 26 17:00:49 CET 2003 ppc GNU/Linux

Mine ist -test9 on x86.

Have you found a solution in the meantime?
