Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130565AbRCDWoC>; Sun, 4 Mar 2001 17:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRCDWnx>; Sun, 4 Mar 2001 17:43:53 -0500
Received: from smarty.smart.net ([207.176.80.102]:34310 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S130544AbRCDWng>;
	Sun, 4 Mar 2001 17:43:36 -0500
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200103042244.RAA17518@smarty.smart.net>
Subject: Re: [Slightly OT] x86 PROM project
To: linux-kernel@vger.kernel.org
Date: Sun, 4 Mar 2001 17:44:06 -0500 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>What does everybody think of the idea of trying to write a RISC PROM-like
>BIOS for the x86 architecture?
>
>I've been tossing the idea around in my head for a while, and after I got
>my first SGI I realized that something like this would be fairly useful.
>Basically, I'm wondering if anybody is already doing something like this
>(not linuxBIOS, though the code for that could be a useful
>base).  Thanks.

Where this is on topic is in comp.lang.forth, since Open Firmware is a
Forth. One of the c.l.f elders recently said he was going to wander off
for a while and come back with what he could find out about this. I've
copied a post or two on this subject to c.l.f since then. 

Related stuff; the FreeBSD bootloader is a Forth based on FICL, which is a
Forth geared to be embedded in apps. In the hour or two I looked at that I
couldn't get my bearings in the FBSD sources. I believe Open Firmware is
bytecodes, and O.F. cards have actual drivers on them an O.F. host can
request and thread into the O.F. dictionary (compile, in other words.)
Most Forths are not bytecodes. Most Forths are address-threaded, or
subroutine threaded, i.e. native code but implementing a true 2-stack
virtual machine, or true 2-stack silicon. This is quite unlike Java, for
example, which has Forth-like stack operators that are
returnstack-frame-scoped, i.e. aren't an autonomous second stack.

Rick Hohensee
www.clienux.com


My 3-stack machine and other oddities are in 
ftp://ftp.gwdg.de/pub/linux/install/clienux/interim


