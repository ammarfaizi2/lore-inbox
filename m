Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318255AbSHMQUK>; Tue, 13 Aug 2002 12:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318268AbSHMQUK>; Tue, 13 Aug 2002 12:20:10 -0400
Received: from mnh-1-01.mv.com ([207.22.10.33]:19973 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318255AbSHMQUF>;
	Tue, 13 Aug 2002 12:20:05 -0400
Message-Id: <200208131727.MAA02464@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: UML 2.5.31
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Aug 2002 12:27:50 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has been updated to 2.5.31 and UML 2.4.18-52.

The changes since 2.5.30 have been mostly bug fixes and cleanups.  

I fixed a "I'm tracing myself and can't get out" race.  

The kernel entry and exit code was cleaned up and reduced from three copies 
to one.

telnetd is now killed when UML shuts down, so telnet connections to UML 
consoles die properly.

Fixed a crash caused by a non-GFP_ATOMIC allocation in an interrupt.

UML now exits when 'debug' is asked for and CONFIG_PT_PROXY is disabled.

Fixed some bugs in the ubd device plugging code.

Fixed ethertap by making CLOEXEC optional in os_pipe.

Made UML build on 2.2 by defining the SHUT_* macros if no header file does.

The patch is available at
	http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.31-1.bz2

For the other UML mirrors and other downloads, see 
	http://user-mode-linux.sourceforge.net/dl-sf.html

Other links of interest:

	The UML project home page : http://user-mode-linux.sourceforge.net
	The UML Community site : http://usermodelinux.org

				Jeff

