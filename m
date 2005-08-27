Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVH0RwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVH0RwP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 13:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVH0RwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 13:52:15 -0400
Received: from WILBUR.CONTACTOFFICE.NET ([212.3.242.68]:24735 "EHLO
	wilbur.contactoffice.net") by vger.kernel.org with ESMTP
	id S932308AbVH0RwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 13:52:14 -0400
Message-ID: <16842018.1125165215948.JavaMail.root@orville>
Date: Sat, 27 Aug 2005 19:53:35 +0200 (CEST)
From: "J. B." <ierland@mail.be>
Reply-To: "J. B." <ierland@mail.be>
To: linux-kernel@vger.kernel.org
Subject: kernel compile error in bootsplash.c
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Origin-IP: 81.243.79.134
X-Mailer: ContactOffice Mail
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to compile a 2.6.10 kernel but it stops with an error
in bootsplash.c. I have everything set in my .config file in /usr/src/linux for bootsplash support. 

Anybody an idea. Where should i start to look? I am a newbie in kernel world

in file included from drivers/video/bootsplash/bootsplash.c:18:
include/linux/fb.h:869: error: array type has incomplete element type
drivers/video/bootsplash/bootsplash.c:37: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:38: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:39: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:40: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:41: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:42: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:43: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:44: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:45: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:46: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:47: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:48: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:49: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:50: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c:52: warning: pointer targets in initialization differ in signedness
drivers/video/bootsplash/bootsplash.c: In function 'splash_verbose':
drivers/video/bootsplash/bootsplash.c:572: warning: pointer targets in passing argument 1 of 'splashcopy' differ in signedness
drivers/video/bootsplash/bootsplash.c:572: warning: pointer targets in passing argument 2 of 'splashcopy' differ in signedness
drivers/video/bootsplash/bootsplash.c: In function 'splash_prepare':
drivers/video/bootsplash/bootsplash.c:642: warning: pointer targets in passing argument 1 of 'splashcopy' differ in signedness
drivers/video/bootsplash/bootsplash.c: In function 'splash_write_proc':
drivers/video/bootsplash/bootsplash.c:788: warning: pointer targets in passing argument 1 of 'boxit' differ in signedness
drivers/video/bootsplash/bootsplash.c:789: warning: pointer targets in passing argument 1 of 'boxit' differ in signedness
make[5]: *** [drivers/video/bootsplash/bootsplash.o] Error 1
make[4]: *** [drivers/video/bootsplash] Error 2
make[3]: *** [drivers/video] Error 2
make[2]: *** [drivers] Error 2
make[2]: Leaving directory `/usr/src/linux-2.6.10'
make[1]: *** [stamp-build] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.10'
make: *** [stamp-buildpackage] Error 2
-----------------------------------------------------
Mail.be, WebMail and Virtual Office
http://www.mail.be

