Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbTIHPbE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbTIHP3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:29:30 -0400
Received: from thor.65535.net ([216.17.104.19]:8716 "EHLO thor.65535.net")
	by vger.kernel.org with ESMTP id S262690AbTIHP2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:28:14 -0400
Date: Mon, 8 Sep 2003 08:27:00 -0700 (PDT)
From: Rus Foster <rghf@fsck.me.uk>
X-X-Sender: rghf@thor.65535.net
To: Jeff Dike <jdike@addtoit.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: promblem compiling skas patch 
In-Reply-To: <200309081526.h88FQMjh029751@ccure.karaya.com>
Message-ID: <20030908082557.G61909@thor.65535.net>
References: <20030908040409.B61909@thor.65535.net>  <200309081526.h88FQMjh029751@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> rghf@fsck.me.uk said:
> > arch/i386/kernel/kernel.o: In function `sys_ptrace':
> > arch/i386/kernel/kernel.o(.text+0x50c9): undefined reference to `proc_mm_get_mm'
>
> This is a mistake in the patch which you can work around by enabling
> CONFIG_PROC_MM.  The patch is kind of pointless if you don't turn that on.

Yeah I foundI've just ofund out what is happening. I use make menuconfig
and there is a slight bug the /proc/mm will only show on the menu if you
select APM (which as it was a server I had turned off). Its just
recompiled cleanly

Thanks

Rus
 --
w: http://www.jvds.com  | Linux + FreeBSD Servers from $15/mo
e: rghf@jvds.com        | Totally Customizable Technology
t: +447919 373537	| Forums
t: 1-888-327-6330 	| http://forums.jvds.com


