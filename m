Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSE2Edv>; Wed, 29 May 2002 00:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314330AbSE2Edu>; Wed, 29 May 2002 00:33:50 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:15787
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S314280AbSE2Edp>; Wed, 29 May 2002 00:33:45 -0400
Message-ID: <3CF45A15.6FC5AA61@rogers.com>
Date: Wed, 29 May 2002 00:33:25 -0400
From: John Kacur <jkacur@rogers.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH][trivial:documentation]linuxdoc->tldp linux2.5
Content-Type: multipart/mixed;
 boundary="------------20DA1529E713DE09EE2F3C22"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.101.229.155] using ID <jkacur@rogers.com> at Wed, 29 May 2002 00:33:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------20DA1529E713DE09EE2F3C22
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch was made against linux-2.5.18
Purpose: Update the documentation to reflect the fact that
www.linux.org is now www.tldp.org
--------------20DA1529E713DE09EE2F3C22
Content-Type: text/plain; charset=us-ascii;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -ur Documentation.orig/DocBook/sis900.tmpl Documentation/DocBook/sis900.tmpl
--- Documentation.orig/DocBook/sis900.tmpl	Wed May 29 00:19:06 2002
+++ Documentation/DocBook/sis900.tmpl	Wed May 29 00:25:17 2002
@@ -323,8 +323,8 @@
 The 1.06 revision can be found in kernel version later than 2.3.15 and pre-2.2.14, 
 and 1.07 revision can be found in kernel version 2.4.0.
 If you have no prior experience in networking under Linux, please read
-<ULink URL="http://www.linuxdoc.org/">Ethernet HOWTO</ULink> and
-<ULink URL="http://www.linuxdoc.org/">Networking HOWTO</ULink> available from
+<ULink URL="http://www.tldp.org/">Ethernet HOWTO</ULink> and
+<ULink URL="http://www.tldp.org/">Networking HOWTO</ULink> available from
 Linux Documentation Project (LDP).
 </Para>
 
@@ -435,7 +435,7 @@
 Typical values are "10baseT"(twisted-pair 10Mbps Ethernet) or "100baseT"
 (twisted-pair 100Mbps Ethernet). For more information on how to configure 
 network interface, please refer to  
-<ULink URL="http://www.linuxdoc.org/">Networking HOWTO</ULink>.
+<ULink URL="http://www.tldp.org/">Networking HOWTO</ULink>.
 </Para>
 
 <Para>
diff -ur Documentation.orig/kernel-docs.txt Documentation/kernel-docs.txt
--- Documentation.orig/kernel-docs.txt	Wed May 29 00:19:08 2002
+++ Documentation/kernel-docs.txt	Wed May 29 00:28:31 2002
@@ -41,7 +41,7 @@
        
      * Title: "The Linux Kernel"
        Author: David A. Rusling.
-       URL: http://www.linuxdoc.org/LDP/tlk/tlk.html
+       URL: http://www.tldp.org/LDP/tlk/tlk.html
        Keywords: everything!, book.
        Description: On line, 200 pages book describing most aspects of
        the Linux Kernel. Probably, the first reference for beginners.
@@ -57,7 +57,7 @@
        
      * Title: "The Linux Kernel Hackers' Guide"
        Author: Michael K.Johnson and others.
-       URL: http://www.linuxdoc.org/LDP/khg/HyperNews/get/khg.html
+       URL: http://www.tldp.org/LDP/khg/HyperNews/get/khg.html
        Keywords: everything!
        Description: No more Postscript book-like version. Only HTML now.
        Many people have contributed. The interface is similar to web
@@ -277,7 +277,7 @@
        
      * Title: "Linux Kernel Module Programming Guide"
        Author: Ori Pomerantz.
-       URL: http://www.linuxdoc.org/LDP/lkmpg/mpg.html
+       URL: http://www.tldp.org/LDP/lkmpg/mpg.html
        Keywords: modules, GPL book, /proc, ioctls, system calls,
        interrupt handlers .
        Description: Very nice 92 pages GPL book on the topic of modules
diff -ur Documentation.orig/scsi-generic.txt Documentation/scsi-generic.txt
--- Documentation.orig/scsi-generic.txt	Wed May 29 00:19:08 2002
+++ Documentation/scsi-generic.txt	Wed May 29 00:28:56 2002
@@ -30,7 +30,7 @@
 =======================
 The most recent documentation of the sg driver is kept at the Linux
 Documentation Project's (LDP) site: 
-http://www.linuxdoc.org/HOWTO/SCSI-Generic-HOWTO
+http://www.tldp.org/HOWTO/SCSI-Generic-HOWTO
 This describes the sg version 3 driver found in the lk 2.4 series.
 The LDP renders documents in single and multiple page HTML, postscript
 and pdf. This document can also be found at:
@@ -51,7 +51,7 @@
 can be found at the top of the /usr/src/linux/drivers/scsi/sg.c file.
 
 A more general description of the Linux SCSI subsystem of which sg is a 
-part can be found at http://www.linuxdoc.org/HOWTO/SCSI-2.4-HOWTO .
+part can be found at http://www.tldp.org/HOWTO/SCSI-2.4-HOWTO .
 
 
 Example code and utilities
diff -ur Documentation.orig/scsi.txt Documentation/scsi.txt
--- Documentation.orig/scsi.txt	Wed May 29 00:19:07 2002
+++ Documentation/scsi.txt	Wed May 29 00:27:56 2002
@@ -2,7 +2,7 @@
 ============================
 The Linux Documentation Project (LDP) maintains a document describing
 the SCSI subsystem in the Linux kernel (lk) 2.4 series. See:
-http://www.linuxdoc.org/HOWTO/SCSI-2.4-HOWTO . The LDP has single
+http://www.tldp.org/HOWTO/SCSI-2.4-HOWTO . The LDP has single
 and multiple page HTML renderings as well as postscript and pdf.
 It can also be found at http://www.torque.net/scsi/SCSI-2.4-HOWTO .
 
diff -ur Documentation.orig/sound/oss/PAS16 Documentation/sound/oss/PAS16
--- Documentation.orig/sound/oss/PAS16	Wed May 29 00:19:07 2002
+++ Documentation/sound/oss/PAS16	Wed May 29 00:26:53 2002
@@ -71,7 +71,7 @@
   interrupt and DMA channel), because you will be asked for it.
 
   You want to read the Sound-HOWTO, available from
-  http://www.linuxdoc.org/docs.html#howto . General information
+  http://www.tldp.org/docs.html#howto . General information
   about the modular sound system is contained in the files
   Documentation/sound/Introduction. The file
   Documentation/sound/README.OSS contains some slightly outdated but

--------------20DA1529E713DE09EE2F3C22--

