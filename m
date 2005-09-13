Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVIMO1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVIMO1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVIMO1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:27:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932648AbVIMO1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:27:17 -0400
Date: Tue, 13 Sep 2005 07:27:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
In-Reply-To: <1126583669.5708.18.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509130725420.3351@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
 <1126583669.5708.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Sep 2005, Alejandro Bonilla Beeche wrote:
> 
> debian:~# cat getkernelupdate
> #! /bin/bash
> cd linux-2.6
> git pull rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> git checkout
> 
> 
> I use getkernelupdate to "download the updated git with the new patches
> sent.
> 
> If I do make menuconfig, it still says 2.6.13 instead of 2.6.14-rc1.

I suspect that you were just hit by the kernel.org mirroring delay. The 
change to the Makefile is the very last thing I do before a release, so 
if the mirrors are slow, you won't get that change for about half an hour 
or so..

		Linus
