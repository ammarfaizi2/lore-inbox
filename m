Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAaDet>; Tue, 30 Jan 2001 22:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130107AbRAaDek>; Tue, 30 Jan 2001 22:34:40 -0500
Received: from mnh-1-13.mv.com ([207.22.10.45]:60430 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S129742AbRAaDe1>;
	Tue, 30 Jan 2001 22:34:27 -0500
Message-Id: <200101310444.XAA04925@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.38-2.4.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jan 2001 23:44:37 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.1 is available.

I added support for attaching file descriptors and pts devices to UML serial 
lines and consoles, plus specifying input and output channels separately.  
'no-xterm' can now be duplicated with 'con0=fd:0,fd:1 con=pty'.

There is now page dirty and access bit support.

Fixed various bugs - gdb is now told where the binary really is, rather than 
assuming that it is ./linux, kreiserfsd now exits correctly, rather than 
hanging the system when it returns, and a recursively segfaulting process no 
longer crashes the system.

Several more symbols were exported.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at http://sourceforge.net/project/filelist.php?group_id
=429 and ftp://ftp.nl.linux.org/pub/uml/

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
