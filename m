Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277132AbRJINLY>; Tue, 9 Oct 2001 09:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277182AbRJINLP>; Tue, 9 Oct 2001 09:11:15 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:55826 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S277132AbRJINLG>;
	Tue, 9 Oct 2001 09:11:06 -0400
Date: Tue, 9 Oct 2001 15:11:34 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.11-pre6 and 2.4.10-ac10] MotionEye camera documentation update
Message-ID: <20011009151134.H15740@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchlet updates the documentation for the MotionEye
Vaio camera driver.

I've got several complaining about this comment missing, 
so here it is.

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.10-ac10.orig/Documentation/video4linux/meye.txt linux-2.4.10-ac10/Documentation/video4linux/meye.txt
--- linux-2.4.10-ac10.orig/Documentation/video4linux/meye.txt	Wed Jul  4 23:41:33 2001
+++ linux-2.4.10-ac10/Documentation/video4linux/meye.txt	Tue Oct  9 10:45:21 2001
@@ -4,7 +4,10 @@
 	Copyright (C) 2000 Andrew Tridgell <tridge@samba.org>
 
 This driver enable the use of video4linux compatible applications with the
-Motion Eye camera.
+Motion Eye camera. This driver requires the "Sony Vaio Programmable I/O 
+Control Device" driver (which can be found in the "Character drivers" 
+section of the kernel configuration utility) to be compiled and installed
+(using its "camera=1" parameter).
 
 It can do at maximum 30 fps @ 320x240 or 15 fps @ 640x480.
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
