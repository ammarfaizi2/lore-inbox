Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSGFSZj>; Sat, 6 Jul 2002 14:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315754AbSGFSZi>; Sat, 6 Jul 2002 14:25:38 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:33509 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S315746AbSGFSZh>; Sat, 6 Jul 2002 14:25:37 -0400
Date: Sat, 6 Jul 2002 03:16:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: user-mode port 0.58-2.4.18-36
Message-ID: <20020706011643.GD112@elf.ucw.cz>
References: <200207052250.RAA03199@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207052250.RAA03199@ccure.karaya.com>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is the fourth release of the 2.4.18 UML.
> 
> The major changes in this release include:
> 
> 	It is now possible the to attach the UML gdb to sleeping threads.
> 	This is done by detaching gdb from the in-context thread and attaching
> 	it to the host pid of the sleeping UML process.  UML may be continued
> 	by reattaching to the in-context thread.  This feature was sponsored
> 	by Cluster File Systems, Inc.
> 
> 	There is a /proc/exitcode, which allows a UML process to set the
> 	eventual UML exit code.
> 
> 	Fixed some segfaults caused by calling openpty, which has an unusually
> 	large stack frame, overflowing the UML kernel stack.
> 
> 	The tty logging patch is integrated.  This allows UML honeypots to
> 	log all tty traffic to a host file.  This logging can't be detected
> 	or interfered with by root inside the UML.

So... what prevents uml root from inserting rogue module (perhaps
using /dev/kmem) and escape the jail?

> 	The UML binary now lives in its own physical memory.  This makes it
> 	easier for the swsusp patch to be ported to UML.

Good ;-).
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
