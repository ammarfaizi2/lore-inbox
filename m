Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264030AbTCUUd0>; Fri, 21 Mar 2003 15:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263746AbTCUTRx>; Fri, 21 Mar 2003 14:17:53 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44932
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263739AbTCUTRh>; Fri, 21 Mar 2003 14:17:37 -0500
Date: Fri, 21 Mar 2003 20:32:52 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212032.h2LKWqAB026377@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update docbook includes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/Documentation/DocBook/kernel-api.tmpl linux-2.5.65-ac2/Documentation/DocBook/kernel-api.tmpl
--- linux-2.5.65/Documentation/DocBook/kernel-api.tmpl	2003-03-06 17:04:22.000000000 +0000
+++ linux-2.5.65-ac2/Documentation/DocBook/kernel-api.tmpl	2003-03-14 00:51:53.000000000 +0000
@@ -89,7 +89,11 @@
      <title>Memory Management in Linux</title>
      <sect1><title>The Slab Cache</title>
 !Emm/slab.c
-      </sect1>
+     </sect1>
+     <sect1><title>User Space Memory Access</title>
+!Iinclude/asm-i386/uaccess.h
+!Iarch/i386/lib/usercopy.c
+     </sect1>
   </chapter>
 
   <chapter id="proc">
@@ -173,7 +177,6 @@
      </sect1>
      <sect1><title>PCI Hotplug Support Library</title>
 !Edrivers/hotplug/pci_hotplug_core.c
-!Edrivers/hotplug/pci_hotplug_util.c
      </sect1>
      <sect1><title>MCA Architecture</title>
 	<sect2><title>MCA Device Functions</title>
