Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316221AbSFUETN>; Fri, 21 Jun 2002 00:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSFUETM>; Fri, 21 Jun 2002 00:19:12 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:14791 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316213AbSFUETL>;
	Fri, 21 Jun 2002 00:19:11 -0400
Date: Fri, 21 Jun 2002 14:18:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jaroslav Kysela <perex@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] cs46xx.c needs init.h
Message-Id: <20020621141816.1388e2da.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch was included in 2.5.23, but removed in 2.5.24.  I guess
I should have sent it to the maintainer in the first place ...

This allows the cs46xx driver to build.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.24/sound/pci/cs46xx/cs46xx.c 2.5.24-sfr.1/sound/pci/cs46xx/cs46xx.c
--- 2.5.24/sound/pci/cs46xx/cs46xx.c	Fri Jun 21 10:23:42 2002
+++ 2.5.24-sfr.1/sound/pci/cs46xx/cs46xx.c	Fri Jun 21 12:30:12 2002
@@ -28,6 +28,7 @@
 #include <sound/driver.h>
 #include <linux/pci.h>
 #include <linux/time.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/cs46xx.h>
 #define SNDRV_GET_ID
