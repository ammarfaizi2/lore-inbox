Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135673AbRD2DW5>; Sat, 28 Apr 2001 23:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135676AbRD2DWs>; Sat, 28 Apr 2001 23:22:48 -0400
Received: from mnh-1-23.mv.com ([207.22.10.55]:16398 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S135673AbRD2DWd>;
	Sat, 28 Apr 2001 23:22:33 -0400
Message-Id: <200104290435.XAA05395@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.41-2.4.4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Apr 2001 23:35:21 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.4 is available.

The swap problems that were in the 2.4.3 UML are fixed.

It is now possible to attach already-running debuggers and debuggers other 
than gdb to UML.  See http://user-mode-linux.sourceforge.net/debugging.html 
for details.  There, I give an example of using strace as an alternate 
debugger.

gprof and gcov support now work again.  They can be enabled during 
configuration under the 'Kernel Hacking' menu.

UML can boot from an initrd image.  This done with 'initrd=<image>' on the 
command line.

I fixed a long-standing race which caused sleep to hang.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at http://sourceforge.net/project/filelist.php?group_id
=429 and ftp://ftp.nl.linux.org/pub/uml/

				Jeff




