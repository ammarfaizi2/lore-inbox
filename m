Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVHUXPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVHUXPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 19:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVHUXPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 19:15:21 -0400
Received: from pop.gmx.net ([213.165.64.20]:25038 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751119AbVHUXPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 19:15:21 -0400
X-Authenticated: #12114349
Message-Id: <6.2.1.2.2.20050822010109.026b97d0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Mon, 22 Aug 2005 01:14:59 +0200
To: linux-kernel@vger.kernel.org
From: Konstantin Koll <konstantinkoll@gmx.de>
Subject: Driver for proprietary Sony Memorystick drive
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear readers,

I'm the owner of a Sony VAIO notebook with a PCI-based memorystick drive, 
PCI ID is 104D/808A. So far, no Linux driver has been developed. I am quite 
experienced with driver development, though not for Linux.

Background:
I work on a DOS-based OS ( http://www.deskwork.de/ ), written in Borland 
Pascal and Assembler for Protected Mode, thus I'm fairly experienced with 
driver development from scratch. My plan is to write a driver in BP and 
release it along with lots of comments and a neat PDF specification into 
the public domain, ready to be ported to Linux, Zeta or whatever.

How far I got:
I was able to assign 1 KB of I/O memory to the device (the amount it gets 
under Windows). At offset 100h, a 512 byte buffer is located. The byte at 
offset 08h indicates whether a stick is inserted (=01h) or not (=00h). The 
512 byte buffer shows strange behaviour (no details here), and I cannot 
read or write anything yet.

Needed:
It would be helpful to get in touch with people who develop drivers and/or 
own a Sony laptop with said drive for testing. I think it's still a quite 
long way to go. I am currently not subscribed to the kernel mailing list.

Kind regards,
Konstantin Koll
Hansmannstr. 17
44227 Dortmund
konstantinkoll@gmx.de

