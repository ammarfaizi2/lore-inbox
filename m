Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266551AbRGIKGw>; Mon, 9 Jul 2001 06:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbRGIKGc>; Mon, 9 Jul 2001 06:06:32 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:18705 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S266551AbRGIKG1>;
	Mon, 9 Jul 2001 06:06:27 -0400
Date: Mon, 9 Jul 2001 12:06:25 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.6-ac2] CONFIG_FB_ATY_CT_VAIO_LCD documentation.
Message-ID: <20010709120625.C4850@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol CONFIG_FB_ATY_CT_VAIO_LCD does not have an associated
documentation in Configure.help.

The attached patch fix it.

diff -uNr --exclude-from=dontdiff linux-2.4.6-ac2.orig/Documentation/Configure.help linux-2.4.6-ac2/Documentation/Configure.help
--- linux-2.4.6-ac2.orig/Documentation/Configure.help	Mon Jul  9 10:26:58 2001
+++ linux-2.4.6-ac2/Documentation/Configure.help	Mon Jul  9 11:48:51 2001
@@ -4345,6 +4345,15 @@
   The ATI product support page for these boards is at
   <http://support.ati.com/products/pc/mach64/>.
 
+Sony Vaio Picturebook laptop LCD panel support
+CONFIG_FB_ATY_CT_VAIO_LCD
+  Say Y here if you want to use the full width of the Sony Vaio 
+  Picturebook laptops LCD panels (you will get a 128x30 console).
+
+  Note that you need to activate this mode using the 'vga=0x301'
+  option from your boot loader (lilo or loadlin). See the documentation
+  of your boot loader about how to pass options to the kernel.
+  
 # AC tree only
 Mach64 GX support
 CONFIG_FB_ATY_GX

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
