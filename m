Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbRGWDwr>; Sun, 22 Jul 2001 23:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267813AbRGWDwi>; Sun, 22 Jul 2001 23:52:38 -0400
Received: from mnh-1-29.mv.com ([207.22.10.61]:52236 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267812AbRGWDw2>;
	Sun, 22 Jul 2001 23:52:28 -0400
Message-Id: <200107230508.AAA04621@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.44-2.4.7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Jul 2001 00:08:04 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

The user-mode port of 2.4.7 is available.

In a minor packaging breakthrogh, a .deb for UML is now available.

The UML block driver now supports a read-write COW layer above a shared 
read-only filesystem.  This allows multiple UMLs to boot off the same 
filesystem.  See http://user-mode-linux.sourceforge.net/shared_fs.html for
more information.

The ppc port is now fully merged.

The pid file and mconsole socket are now located in a directory defined 
by the UML umid.

There is now IO memory emulation.  This allows a host file to be mapped by a
UML driver, which can provide whatever interface it wants to that file to 
UML processes.  This is a first step towards doing hardware driver development
under UML.

gdbs are now killed properly.

A nasty bug involving a misunderstanding with FASTCALL was fixed.

Block devices and network devices are now pluggable from the mconsole - they
can be added to and removed from a running system.  See 
http://user-mode-linux.sourceforge.net/mconsole.html for more information.

SIGHUP no longer causes UML to go crazy.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://sourceforge.net/project/showfiles.php?group_id=429
	ftp://ftp.nl.linux.org/pub/uml/
	http://uml-pub.ists.dartmouth.edu/uml/

				Jeff

