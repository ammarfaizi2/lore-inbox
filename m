Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbQLRGbG>; Mon, 18 Dec 2000 01:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130758AbQLRGa5>; Mon, 18 Dec 2000 01:30:57 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:2570 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129878AbQLRGax>; Mon, 18 Dec 2000 01:30:53 -0500
Date: Mon, 18 Dec 2000 00:00:01 -0600
To: Albert Cranford <ac9410@bellsouth.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre3
Message-ID: <20001218000001.X3199@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.10.10012171353270.2052-100000@penguin.transmeta.com> <3A3D4FB4.CBA887E4@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A3D4FB4.CBA887E4@bellsouth.net>; from ac9410@bellsouth.net on Sun, Dec 17, 2000 at 11:43:48PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Albert Cranford]
> With CONFIG_DRM_R128=m
> we fail to produce module linux/drivers/char/drm/r128.o

He's right.  Linus, please apply.

Peter

--- test13pre3/drivers/char/Makefile.orig	Wed Dec 13 23:56:01 2000
+++ test13pre3/drivers/char/Makefile	Sun Dec 17 23:55:00 2000
@@ -25,6 +25,7 @@
 			misc.o pty.o random.o selection.o serial.o \
 			tty_io.o
 
+mod-subdirs	:=	joystick ftape drm pcmcia
 list-multi	:=	
 
 KEYMAP   =defkeymap.o
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
