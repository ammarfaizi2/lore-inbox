Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289386AbSA2OjC>; Tue, 29 Jan 2002 09:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289629AbSA2Oiy>; Tue, 29 Jan 2002 09:38:54 -0500
Received: from mx2.elte.hu ([157.181.151.9]:54741 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289386AbSA2Oih>;
	Tue, 29 Jan 2002 09:38:37 -0500
Date: Tue, 29 Jan 2002 17:36:07 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020129152732.G9149@suse.de>
Message-ID: <Pine.LNX.4.33.0201291733500.11959-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Dave Jones wrote:

>  > out of the 300+ email addresses in the MAINTAINERS file, 15 addresses
>  > bounced physically. (whether they bounce logically is another question.)
>
>  Care to remove the bogus ones from MAINTAINERS

yeah, was in the process of doing that. Patch against 2.5.3-pre6 attached.
Altogether 13 addresses are affected. I have only removed the
hard-bouncing email addresses, names and list names remain (of course).

	Ingo

--- linux/MAINTAINERS.orig	Tue Jan 29 15:11:04 2002
+++ linux/MAINTAINERS	Tue Jan 29 15:16:31 2002
@@ -154,8 +154,6 @@

 AD1816 SOUND DRIVER
 P:	Thorsten Knabe
-M:	Thorsten Knabe <tek@rbg.informatik.tu-darmstadt.de>
-M:	Thorsten Knabe <tek01@hrzpub.tu-darmstadt.de>
 W:	http://www.student.informatik.tu-darmstadt.de/~tek/projects/linux.html
 W:	http://www.tu-darmstadt.de/~tek01/projects/linux.html
 S:	Maintained
@@ -216,7 +214,6 @@

 ARPD SUPPORT
 P:	Jonathan Layes
-M:	layes@loran.com
 L:	linux-net@vger.kernel.org
 S:	Maintained

@@ -235,7 +232,6 @@

 BERKSHIRE PRODUCTS PC WATCHDOG DRIVER
 P:	Kenji Hollis
-M:	kenji@bitgate.com
 W:	http://ftp.bitgate.com/pcwd/
 S:	Maintained

@@ -433,13 +429,11 @@
 DIGI INTL. EPCA DRIVER
 P:	Chad Schwartz
 M:      support@dgii.com
-M:      chads@dgii.com
 L:      digilnux@dgii.com
 S:      Maintained

 DIGI RIGHTSWITCH NETWORK DRIVER
 P:	Rick Richardson
-M:	rick@remotepoint.com
 L:	linux-net@vger.kernel.org
 W:	http://www.dgii.com/linux/
 S:	Maintained
@@ -485,7 +479,6 @@

 DRM DRIVERS
 P:	Rik Faith
-M:	faith@valinux.com
 L:	dri-devel@lists.sourceforge.net
 S:	Supported

@@ -497,7 +490,6 @@

 EATA-DMA SCSI DRIVER
 P:	Michael Neuffer
-M:	mike@i-Connect.Net
 L:	linux-eata@i-connect.net, linux-scsi@vger.kernel.org
 S:	Maintained

@@ -927,7 +919,6 @@

 LOGICAL VOLUME MANAGER
 P:     Heinz Mauelshagen
-M:     mge@sistina.de
 L:     linux-LVM@sistina.com
 W:     http://www.sistina.com/lvm
 S:     Maintained
@@ -1134,7 +1125,6 @@

 OLYMPIC NETWORK DRIVER
 P:	Peter De Shrijver
-M:	p2@ace.ulyssis.sutdent.kuleuven.ac.be
 P:	Mike Phillips
 M:	mikep@linuxtr.net
 L:	linux-net@vger.kernel.org
@@ -1293,7 +1283,6 @@

 RISCOM8 DRIVER
 P:	Dmitry Gorodchanin
-M:	pgmdsg@ibi.com
 L:	linux-kernel@vger.kernel.org
 S:	Maintained

@@ -1660,13 +1649,11 @@
 USB SERIAL BELKIN F5U103 DRIVER
 P:	William Greathouse
 M:	wgreathouse@smva.com
-M:	wgreathouse@myfavoritei.com
 L:	linux-usb-users@lists.sourceforge.net
 L:	linux-usb-devel@lists.sourceforge.net
 S:	Maintained

 USB SERIAL CYBERJACK PINPAD/E-COM DRIVER
-M:	linux-usb@sii.li
 L:	linux-usb-users@lists.sourceforge.net
 L:	linux-usb-devel@lists.sourceforge.net
 S:	Supported
@@ -1792,7 +1779,6 @@

 ZF MACHZ WATCHDOG
 P:	Fernando Fuganti
-M:	fuganti@conectiva.com.br
 M:	fuganti@netbank.com.br
 W:	http://cvs.conectiva.com.br/drivers/ZFL-watchdog/
 S:	Maintained

