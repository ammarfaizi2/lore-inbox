Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUHaWys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUHaWys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUHaWwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:52:33 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:7062 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268544AbUHaWuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:50:12 -0400
From: jmerkey@comcast.net
To: Roland Dreier <roland@topspin.com>, "Randy.Dunlap" <rddunlap@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Date: Tue, 31 Aug 2004 22:50:10 +0000
Message-Id: <083120042250.11424.413500A200044BFB00002CA02200748184970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>     Randy> It doesn't barf on me.  I added one other patch on top of
>     Randy> yours: one from Roland Dreier, for
>     Randy> arch/i386/kernel/doublefault.c [below].
> 
> BTW, I can't imagine my patch would make any difference -- it only
> affects what gets printed out right before the kernel locks up on a
> double fault.
> 
> I am running a 2.6.8.1 kernel with PAGE_OFFSET set to 0xb000000 on my
> desktop with USB mouse and keyboard (and 1 GB of RAM) with no problems.
> 
>  - R.


I'll retest on 2.6.9-rc1  At present, the Orinoco 
Wireless USB Adapter does lock 
up my system when I enable 3BG kernel space.  
1 GB and 2 GB kernel address settings
seem to work OK.

Jeff
