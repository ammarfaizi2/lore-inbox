Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUAYTfh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUAYTfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:35:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:15033 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265232AbUAYTfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:35:23 -0500
X-Authenticated: #12437197
Date: Sun, 25 Jan 2004 21:35:18 +0200
From: Dan Aloni <da-x@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Cooperative Linux
Message-ID: <20040125193518.GA32013@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello fellow developers, kernel hackers, and open source contributors,

Cooperative Linux is a port of the Linux kernel which allows it 
to run cooperatively under other operating systems in ring0 without 
hardware emulation, based on very minimal changes in the architecture 
dependent code and almost no changes in functionality.

The bottom line is that it allows us to run Linux on an unmodified
Windows 2000/XP system in a practical way (the user just launches 
an app), and it may eventually bring Linux to a large sector of desktop 
computer users who wouldn't even care about trying to install a 
dual boot system or boot a Linux live CD (like Knoppix).

Screen-shots and further details at:

    http://www.colinux.org

Our motto is:

    "If Linux runs on every architecture, why should another 
     operating system be in its way?"

coLinux is similar to plex86 in a way that it implements a Linux-specific 
lightweight VM with I/O virtualization. However, it is designed to be 
mostly host-OS independent, so that with minimal porting efforts it 
would be possible to run it under Solaris, Linux itself, or any operating 
system that supports loading kernel drivers, under any architecture that 
uses an MMU. Unlike other virtualization methods, it doesn't base its 
implementation on exceptions that are caused by instructions. 

Cooperative Linux is like the kernel mode equivalent of User Mode Linux. 
It relies on the host OS kernel-space interfaces rather than relying on 
host OS user-space interfaces.

Currently, it is stable enough (on some common hardware configurations) 
for running a fully functional KNOPPIX/Debian system on Windows (see 
website screen-shots).

Another project close to achieving that goal is the Windows port of 
User Mode Linux (http://umlwin32.sf.net).

Project page:

    http://sourceforge.net/projects/colinux 

Thank you for your time,

 - The coLinux development team.

This Open Source project is sponsored and produced by AIST, 2004 
http://www.aist.go.jp/

-- 
Dan Aloni
da-x@gmx.net
