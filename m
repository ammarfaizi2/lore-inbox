Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbRGLJWV>; Thu, 12 Jul 2001 05:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbRGLJWM>; Thu, 12 Jul 2001 05:22:12 -0400
Received: from t2.redhat.com ([199.183.24.243]:21751 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267456AbRGLJV7>; Thu, 12 Jul 2001 05:21:59 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] Pedantry.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Jul 2001 10:21:24 +0100
Message-ID: <6845.994929684@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFAIK "Uncompressing" is not a real word even in American.
Please apply this correction.
(Yes, I'm bored today :)

Index: ./arch/arm/boot/compressed/misc.c
===================================================================
RCS file: /inst/cvs/linux/arch/arm/boot/compressed/misc.c,v
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1.2.1 misc.c
--- ./arch/arm/boot/compressed/misc.c	2000/12/04 15:57:41	1.1.1.1.2.1
+++ ./arch/arm/boot/compressed/misc.c	2001/07/12 09:17:30
@@ -293,7 +293,7 @@
 	arch_decomp_setup();
 
 	makecrc();
-	puts("Uncompressing Linux...");
+	puts("Decompressing Linux...");
 	gunzip();
 	puts(" done, booting the kernel.\n");
 	return output_ptr;
@@ -307,7 +307,7 @@
 	output_data = output_buffer;
 
 	makecrc();
-	puts("Uncompressing Linux...");
+	puts("Decompressing Linux...");
 	gunzip();
 	puts("done.\n");
 	return 0;
Index: ./arch/i386/boot/compressed/misc.c
===================================================================
RCS file: /inst/cvs/linux/arch/i386/boot/compressed/misc.c,v
retrieving revision 1.1.1.1.2.7
diff -u -r1.1.1.1.2.7 misc.c
--- ./arch/i386/boot/compressed/misc.c	2001/02/24 19:12:22	1.1.1.1.2.7
+++ ./arch/i386/boot/compressed/misc.c	2001/07/12 09:17:30
@@ -361,7 +361,7 @@
 	else setup_output_buffer_if_we_run_high(mv);
 
 	makecrc();
-	puts("Uncompressing Linux... ");
+	puts("Decompressing Linux... ");
 	gunzip();
 	puts("Ok, booting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
Index: ./arch/ppc/boot/common/misc-simple.c
===================================================================
RCS file: /inst/cvs/linux/arch/ppc/boot/common/Attic/misc-simple.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 misc-simple.c
--- ./arch/ppc/boot/common/misc-simple.c	2001/06/02 16:27:52	1.1.2.1
+++ ./arch/ppc/boot/common/misc-simple.c	2001/07/12 09:17:30
@@ -173,7 +173,7 @@
 	if ( initrd_start > (16<<20))
 		puts("initrd_start located > 16M\n");
        
-	puts("Uncompressing Linux...");
+	puts("Decompressing Linux...");
 
 	gunzip(0, 0x400000, zimage_start, &zimage_size);
 	puts("done.\n");
Index: ./arch/ppc/boot/mbx/misc.c
===================================================================
RCS file: /inst/cvs/linux/arch/ppc/boot/mbx/Attic/misc.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 misc.c
--- ./arch/ppc/boot/mbx/misc.c	2001/06/02 16:27:52	1.1.2.1
+++ ./arch/ppc/boot/mbx/misc.c	2001/07/12 09:17:30
@@ -258,7 +258,7 @@
 		udelay(1000);  /* 1 msec */
 	}
 	*cp = 0;
-	puts("\nUncompressing Linux...");
+	puts("\nDecompressing Linux...");
 
 	gunzip(0, 0x400000, zimage_start, &zimage_size);
 	puts("done.\n");
Index: ./arch/ppc/boot/prep/misc.c
===================================================================
RCS file: /inst/cvs/linux/arch/ppc/boot/prep/Attic/misc.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 misc.c
--- ./arch/ppc/boot/prep/misc.c	2001/07/03 09:34:19	1.1.2.3
+++ ./arch/ppc/boot/prep/misc.c	2001/07/12 09:17:30
@@ -397,7 +397,7 @@
 	if ( initrd_start > (16<<20))
 		puts("initrd_start located > 16M\n");
 
-	puts("Uncompressing Linux...");
+	puts("Decompressing Linux...");
 	
 	gunzip(0, 0x400000, zimage_start, &zimage_size);
 	puts("done.\n");
Index: ./arch/sh/boot/compressed/misc.c
===================================================================
RCS file: /inst/cvs/linux/arch/sh/boot/compressed/Attic/misc.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 misc.c
--- ./arch/sh/boot/compressed/misc.c	2000/12/05 10:39:22	1.1.2.2
+++ ./arch/sh/boot/compressed/misc.c	2001/07/12 09:17:30
@@ -232,7 +232,7 @@
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
 	makecrc();
-	puts("Uncompressing Linux... ");
+	puts("Decompressing Linux... ");
 	gunzip();
 	puts("Ok, booting the kernel.\n");
 }
Index: ./arch/cris/boot/compressed/misc.c
===================================================================
RCS file: /inst/cvs/linux/arch/cris/boot/compressed/Attic/misc.c,v
retrieving revision 1.1.2.4
diff -u -r1.1.2.4 misc.c
--- ./arch/cris/boot/compressed/misc.c	2001/05/14 10:36:05	1.1.2.4
+++ ./arch/cris/boot/compressed/misc.c	2001/07/12 09:17:30
@@ -267,7 +267,7 @@
 		while(1);
 	}
 
-	puts("Uncompressing Linux...\n");
+	puts("Decompressing Linux...\n");
 	gunzip();
 	puts("Done. Now booting the kernel.\n");
 }

--
dwmw2


