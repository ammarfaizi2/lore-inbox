Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVCCMSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVCCMSf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVCCLEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:04:23 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:6836 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261566AbVCCKma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:42:30 -0500
Date: Thu, 3 Mar 2005 11:42:14 +0100
Message-Id: <200503031042.j23AgEgr020734@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 8/16] DocBook: convert template files to XML
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: convert template files to XML
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2032  -> 1.2033 
#	Documentation/DocBook/scsidrivers.tmpl	1.4     -> 1.5    
#	Documentation/DocBook/kernel-api.tmpl	1.33    -> 1.34   
#	Documentation/DocBook/journal-api.tmpl	1.6     -> 1.7    
#	Documentation/DocBook/wanbook.tmpl	1.1     -> 1.2    
#	Documentation/DocBook/z8530book.tmpl	1.1     -> 1.2    
#	Documentation/DocBook/tulip-user.tmpl	1.3     -> 1.4    
#	Documentation/DocBook/kernel-locking.tmpl	1.13    -> 1.14   
#	Documentation/DocBook/deviceiobook.tmpl	1.6     -> 1.7    
#	Documentation/DocBook/libata.tmpl	1.3     -> 1.4    
#	Documentation/DocBook/writing_usb_driver.tmpl	1.7     -> 1.8    
#	Documentation/DocBook/gadget.tmpl	1.5     -> 1.6    
#	Documentation/DocBook/kernel-hacking.tmpl	1.19    -> 1.20   
#	Documentation/DocBook/sis900.tmpl	1.5     -> 1.6    
#	Documentation/DocBook/mtdnand.tmpl	1.1     -> 1.2    
#	Documentation/DocBook/mcabook.tmpl	1.1     -> 1.2    
#	Documentation/DocBook/procfs-guide.tmpl	1.5     -> 1.6    
#	Documentation/DocBook/lsm.tmpl	1.3     -> 1.4    
#	Documentation/DocBook/librs.tmpl	1.2     -> 1.3    
#	Documentation/DocBook/videobook.tmpl	1.7     -> 1.8    
#	Documentation/DocBook/usb.tmpl	1.4     -> 1.5    
#	Documentation/DocBook/via-audio.tmpl	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/02/08	tali@admingilde.org	1.2033
# DocBook: convert template files to XML
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/deviceiobook.tmpl b/Documentation/DocBook/deviceiobook.tmpl
--- a/Documentation/DocBook/deviceiobook.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/deviceiobook.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="DoingIO">
  <bookinfo>
diff -Nru a/Documentation/DocBook/gadget.tmpl b/Documentation/DocBook/gadget.tmpl
--- a/Documentation/DocBook/gadget.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/gadget.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,7 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
+
 <book id="USB-Gadget-API">
   <bookinfo>
     <title>USB Gadget API for Linux</title>
diff -Nru a/Documentation/DocBook/journal-api.tmpl b/Documentation/DocBook/journal-api.tmpl
--- a/Documentation/DocBook/journal-api.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/journal-api.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,7 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
+
 <book id="LinuxJBDAPI">
  <bookinfo>
   <title>The Linux Journalling API</title>
diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/kernel-api.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,7 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
+
 <book id="LinuxKernelAPI">
  <bookinfo>
   <title>The Linux Kernel API</title>
diff -Nru a/Documentation/DocBook/kernel-hacking.tmpl b/Documentation/DocBook/kernel-hacking.tmpl
--- a/Documentation/DocBook/kernel-hacking.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/kernel-hacking.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="lk-hacking-guide">
  <bookinfo>
diff -Nru a/Documentation/DocBook/kernel-locking.tmpl b/Documentation/DocBook/kernel-locking.tmpl
--- a/Documentation/DocBook/kernel-locking.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/kernel-locking.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="LKLockingGuide">
  <bookinfo>
@@ -236,12 +238,12 @@
      your task will put itself on the queue, and be woken up when the
      semaphore is released.  This means the CPU will do something
      else while you are waiting, but there are many cases when you
-     simply can't sleep (see <xref linkend="sleeping-things">), and so
+     simply can't sleep (see <xref linkend="sleeping-things"/>), and so
      have to use a spinlock instead.
    </para>
    <para>
      Neither type of lock is recursive: see
-     <xref linkend="deadlock">.
+     <xref linkend="deadlock"/>.
    </para>
    </sect1>
  
@@ -326,7 +328,7 @@
     <para>
       Note that you can also use <function>spin_lock_irq()</function>
       or <function>spin_lock_irqsave()</function> here, which stop
-      hardware interrupts as well: see <xref linkend="hardirq-context">.
+      hardware interrupts as well: see <xref linkend="hardirq-context"/>.
     </para>
 
     <para>
@@ -403,7 +405,7 @@
 
      <para>
        The same softirq can run on the other CPUs: you can use a
-       per-CPU array (see <xref linkend="per-cpu">) for better
+       per-CPU array (see <xref linkend="per-cpu"/>) for better
        performance.  If you're going so far as to use a softirq,
        you probably care about scalable performance enough
        to justify the extra complexity.
@@ -545,120 +547,120 @@
    </para>
    <table>
 <title>Table of Locking Requirements</title>
-<TGROUP COLS="11">
-<TBODY>
-<ROW>
-<ENTRY></ENTRY>
-<ENTRY>IRQ Handler A</ENTRY>
-<ENTRY>IRQ Handler B</ENTRY>
-<ENTRY>Softirq A</ENTRY>
-<ENTRY>Softirq B</ENTRY>
-<ENTRY>Tasklet A</ENTRY>
-<ENTRY>Tasklet B</ENTRY>
-<ENTRY>Timer A</ENTRY>
-<ENTRY>Timer B</ENTRY>
-<ENTRY>User Context A</ENTRY>
-<ENTRY>User Context B</ENTRY>
-</ROW>
-
-<ROW>
-<ENTRY>IRQ Handler A</ENTRY>
-<ENTRY>None</ENTRY>
-</ROW>
-
-<ROW>
-<ENTRY>IRQ Handler B</ENTRY>
-<ENTRY>spin_lock_irqsave</ENTRY>
-<ENTRY>None</ENTRY>
-</ROW>
-
-<ROW>
-<ENTRY>Softirq A</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-</ROW>
-
-<ROW>
-<ENTRY>Softirq B</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-</ROW>
-
-<ROW>
-<ENTRY>Tasklet A</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>None</ENTRY>
-</ROW>
-
-<ROW>
-<ENTRY>Tasklet B</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>None</ENTRY>
-</ROW>
-
-<ROW>
-<ENTRY>Timer A</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>None</ENTRY>
-</ROW>
-
-<ROW>
-<ENTRY>Timer B</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>spin_lock</ENTRY>
-<ENTRY>None</ENTRY>
-</ROW>
-
-<ROW>
-<ENTRY>User Context A</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>None</ENTRY>
-</ROW>
-
-<ROW>
-<ENTRY>User Context B</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock_irq</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>spin_lock_bh</ENTRY>
-<ENTRY>down_interruptible</ENTRY>
-<ENTRY>None</ENTRY>
-</ROW>
-
-</TBODY>
-</TGROUP>
-</TABLE>
+<tgroup cols="11">
+<tbody>
+<row>
+<entry></entry>
+<entry>IRQ Handler A</entry>
+<entry>IRQ Handler B</entry>
+<entry>Softirq A</entry>
+<entry>Softirq B</entry>
+<entry>Tasklet A</entry>
+<entry>Tasklet B</entry>
+<entry>Timer A</entry>
+<entry>Timer B</entry>
+<entry>User Context A</entry>
+<entry>User Context B</entry>
+</row>
+
+<row>
+<entry>IRQ Handler A</entry>
+<entry>None</entry>
+</row>
+
+<row>
+<entry>IRQ Handler B</entry>
+<entry>spin_lock_irqsave</entry>
+<entry>None</entry>
+</row>
+
+<row>
+<entry>Softirq A</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock</entry>
+</row>
+
+<row>
+<entry>Softirq B</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+</row>
+
+<row>
+<entry>Tasklet A</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+<entry>None</entry>
+</row>
+
+<row>
+<entry>Tasklet B</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+<entry>None</entry>
+</row>
+
+<row>
+<entry>Timer A</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+<entry>None</entry>
+</row>
+
+<row>
+<entry>Timer B</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+<entry>spin_lock</entry>
+<entry>None</entry>
+</row>
+
+<row>
+<entry>User Context A</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock_bh</entry>
+<entry>spin_lock_bh</entry>
+<entry>spin_lock_bh</entry>
+<entry>spin_lock_bh</entry>
+<entry>spin_lock_bh</entry>
+<entry>spin_lock_bh</entry>
+<entry>None</entry>
+</row>
+
+<row>
+<entry>User Context B</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock_irq</entry>
+<entry>spin_lock_bh</entry>
+<entry>spin_lock_bh</entry>
+<entry>spin_lock_bh</entry>
+<entry>spin_lock_bh</entry>
+<entry>spin_lock_bh</entry>
+<entry>spin_lock_bh</entry>
+<entry>down_interruptible</entry>
+<entry>None</entry>
+</row>
+
+</tbody>
+</tgroup>
+</table>
 </sect1>
 </chapter>
 
diff -Nru a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
--- a/Documentation/DocBook/libata.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/libata.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="libataDevGuide">
  <bookinfo>
diff -Nru a/Documentation/DocBook/librs.tmpl b/Documentation/DocBook/librs.tmpl
--- a/Documentation/DocBook/librs.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/librs.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="Reed-Solomon-Library-Guide">
  <bookinfo>
diff -Nru a/Documentation/DocBook/lsm.tmpl b/Documentation/DocBook/lsm.tmpl
--- a/Documentation/DocBook/lsm.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/lsm.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,6 +1,9 @@
-<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
+
 <article class="whitepaper" id="LinuxSecurityModule" lang="en">
- <artheader>
+ <articleinfo>
  <title>Linux Security Modules:  General Security Hooks for Linux</title>
  <authorgroup>
  <author>
@@ -28,7 +31,7 @@
  </affiliation>
  </author>
  </authorgroup>
- </artheader>
+ </articleinfo>
 
 <sect1><title>Introduction</title>
 
@@ -84,7 +87,7 @@
 modules.  The LSM kernel patch also moves most of the capabilities
 logic into an optional security module, with the system defaulting
 to the traditional superuser logic.  This capabilities module
-is discussed further in <XRef LinkEnd="cap">.
+is discussed further in <xref linkend="cap"/>.
 </para>
 
 <para>
diff -Nru a/Documentation/DocBook/mcabook.tmpl b/Documentation/DocBook/mcabook.tmpl
--- a/Documentation/DocBook/mcabook.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/mcabook.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="MCAGuide">
  <bookinfo>
diff -Nru a/Documentation/DocBook/mtdnand.tmpl b/Documentation/DocBook/mtdnand.tmpl
--- a/Documentation/DocBook/mtdnand.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/mtdnand.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="MTD-NAND-Guide">
  <bookinfo>
diff -Nru a/Documentation/DocBook/procfs-guide.tmpl b/Documentation/DocBook/procfs-guide.tmpl
--- a/Documentation/DocBook/procfs-guide.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/procfs-guide.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,5 +1,6 @@
-<!-- -*- sgml -*- -->
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" [
 <!ENTITY procfsexample SYSTEM "procfs_example.sgml">
 ]>
 
@@ -205,7 +206,7 @@
         function will return a pointer to the freshly created
         <structname>struct proc_dir_entry</structname>; otherwise it
         will return <constant>NULL</constant>. <xref
-        linkend="userland"> describes how to do something useful with
+        linkend="userland"/> describes how to do something useful with
         regular files.
       </para>
 
@@ -221,7 +222,7 @@
     <para>
       If you only want to be able to read the file, the function
       <function>create_proc_read_entry</function> described in <xref
-      linkend="convenience"> may be used to create and initialise
+      linkend="convenience"/> may be used to create and initialise
       the procfs entry in one single call.
     </para>
     </sect1>
@@ -298,7 +299,7 @@
         the <structname>struct proc_dir_entry</structname> before
         <function>remove_proc_entry</function> is called (that is: if
         there was some <structfield>data</structfield> allocated, of
-        course). See <xref linkend="usingdata"> for more information
+        course). See <xref linkend="usingdata"/> for more information
         on using the <structfield>data</structfield> entry.
       </para>
     </sect1>
@@ -333,7 +334,7 @@
       If you only want to use a the
       <structfield>read_proc</structfield>, the function
       <function>create_proc_read_entry</function> described in <xref
-      linkend="convenience"> may be used to create and initialise the
+      linkend="convenience"/> may be used to create and initialise the
       procfs entry in one single call.
     </para>
 
@@ -386,7 +387,7 @@
         The parameter <parameter>start</parameter> doesn't seem to be
         used anywhere in the kernel. The <parameter>data</parameter>
         parameter can be used to create a single call back function for
-        several files, see <xref linkend="usingdata">.
+        several files, see <xref linkend="usingdata"/>.
       </para>
 
       <para>
@@ -395,7 +396,7 @@
       </para>
 
       <para>
-        <xref linkend="example"> shows how to use a read call back
+        <xref linkend="example"/> shows how to use a read call back
         function.
       </para>
     </sect1>
@@ -429,12 +430,12 @@
         kernel's memory space, so it should first be copied to kernel
         space with <function>copy_from_user</function>. The
         <parameter>file</parameter> parameter is usually
-        ignored. <xref linkend="usingdata"> shows how to use the
+        ignored. <xref linkend="usingdata"/> shows how to use the
         <parameter>data</parameter> parameter.
       </para>
 
       <para>
-        Again, <xref linkend="example"> shows how to use this call back
+        Again, <xref linkend="example"/> shows how to use this call back
         function.
       </para>
     </sect1>
@@ -525,10 +526,10 @@
       <para>
         This function creates a regular file in exactly the same way
         as <function>create_proc_entry</function> from <xref
-        linkend="regularfile"> does, but also allows to set the read
+        linkend="regularfile"/> does, but also allows to set the read
         function <parameter>read_proc</parameter> in one call. This
         function can set the <parameter>data</parameter> as well, like
-        explained in <xref linkend="usingdata">.
+        explained in <xref linkend="usingdata"/>.
       </para>
     </sect1>
 
diff -Nru a/Documentation/DocBook/scsidrivers.tmpl b/Documentation/DocBook/scsidrivers.tmpl
--- a/Documentation/DocBook/scsidrivers.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/scsidrivers.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,5 +1,6 @@
-<!-- -*- sgml -*- -->
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V4.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="scsidrivers">
  <bookinfo>
diff -Nru a/Documentation/DocBook/sis900.tmpl b/Documentation/DocBook/sis900.tmpl
--- a/Documentation/DocBook/sis900.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/sis900.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,25 +1,27 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="SiS900Guide">
 
 <bookinfo>
 
-<title>SiS 900/7016 Fast Ethernet Device Driver</Title>
+<title>SiS 900/7016 Fast Ethernet Device Driver</title>
 
 <authorgroup>
 <author>
-<FirstName>Ollie</FirstName>
+<firstname>Ollie</firstname>
 <surname>Lho</surname>
 </author>
 
 <author>
-<FirstName>Lei Chun</FirstName>
+<firstname>Lei Chun</firstname>
 <surname>Chang</surname>
 </author>
 </authorgroup>
 
 <edition>Document Revision: 0.3 for SiS900 driver v1.06 & v1.07</edition>
-<PubDate>November 16, 2000</PubDate>
+<pubdate>November 16, 2000</pubdate>
 
 <copyright>
  <year>1999</year>
@@ -48,21 +50,21 @@
  </para>
 </legalnotice>
 
-<Abstract>
-<Para>
+<abstract>
+<para>
 This document gives some information on installation and usage of SiS 900/7016
 device driver under Linux.
-</Para>
-</Abstract>
+</para>
+</abstract>
 
 </bookinfo>
 
 <toc></toc>
 
 <chapter id="intro">
- <Title>Introduction</Title>
+ <title>Introduction</title>
 
-<Para>
+<para>
 This document describes the revision 1.06 and 1.07 of SiS 900/7016 Fast Ethernet 
 device driver under Linux. The driver is developed by Silicon Integrated
 System Corp. and distributed freely under the GNU General Public License (GPL).
@@ -70,265 +72,265 @@
 version 2.2.x. (rev. 1.06)
 With minimal changes, the driver can also be used under 2.3.x and 2.4.x kernel 
 (rev. 1.07), please see 
-<XRef LinkEnd="install">. If you are intended to 
+<xref linkend="install"/>. If you are intended to 
 use the driver for earlier kernels, you are on your own.
-</Para>
+</para>
 
-<Para>
+<para>
 The driver is tested with usual TCP/IP applications including
 FTP, Telnet, Netscape etc. and is used constantly by the developers.
-</Para>
+</para>
 
-<Para>
+<para>
 Please send all comments/fixes/questions to
-<ULink URL="mailto:lcchang@sis.com.tw">Lei-Chun Chang</ULink>.
-</Para>
+<ulink url="mailto:lcchang@sis.com.tw">Lei-Chun Chang</ulink>.
+</para>
 </chapter>
 
 <chapter id="changes">
- <Title>Changes</Title>
+ <title>Changes</title>
 
-<Para>
+<para>
 Changes made in Revision 1.07
 
-<OrderedList>
-<ListItem>
-<Para>
+<orderedlist>
+<listitem>
+<para>
 Separation of sis900.c and sis900.h in order to move most 
 constant definition to sis900.h (many of those constants were
 corrected)
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Clean up PCI detection, the pci-scan from Donald Becker were not used,
 just simple pci&lowbar;find&lowbar;*.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 MII detection is modified to support multiple mii transceiver.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Bugs in read&lowbar;eeprom, mdio&lowbar;* were removed.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Lot of sis900 irrelevant comments were removed/changed and
 more comments were added to reflect the real situation.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Clean up of physical/virtual address space mess in buffer 
 descriptors.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Better transmit/receive error handling.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 The driver now uses zero-copy single buffer management
 scheme to improve performance.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Names of variables were changed to be more consistent.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Clean up of auo-negotiation and timer code.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Automatic detection and change of PHY on the fly.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Bug in mac probing fixed.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Fix 630E equalier problem by modifying the equalizer workaround rule.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Support for ICS1893 10/100 Interated PHYceiver.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Support for media select by ifconfig.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 Added kernel-doc extratable documentation.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-</OrderedList>
-</Para>
+</orderedlist>
+</para>
 </chapter>
 
 <chapter id="tested">
- <Title>Tested Environment</Title>
+ <title>Tested Environment</title>
 
-<Para>
+<para>
 This driver is developed on the following hardware
 
-<ItemizedList>
-<ListItem>
+<itemizedlist>
+<listitem>
 
-<Para>
+<para>
 Intel Celeron 500 with SiS 630 (rev 02) chipset
-</Para>
-</ListItem>
-<ListItem>
+</para>
+</listitem>
+<listitem>
 
-<Para>
+<para>
 SiS 900 (rev 01) and SiS 7016/7014 Fast Ethernet Card
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-</ItemizedList>
+</itemizedlist>
 
 and tested with these software environments
 
-<ItemizedList>
-<ListItem>
+<itemizedlist>
+<listitem>
 
-<Para>
+<para>
 Red Hat Linux version 6.2
-</Para>
-</ListItem>
-<ListItem>
+</para>
+</listitem>
+<listitem>
 
-<Para>
+<para>
 Linux kernel version 2.4.0
-</Para>
-</ListItem>
-<ListItem>
+</para>
+</listitem>
+<listitem>
 
-<Para>
+<para>
 Netscape version 4.6
-</Para>
-</ListItem>
-<ListItem>
+</para>
+</listitem>
+<listitem>
 
-<Para>
+<para>
 NcFTP 3.0.0 beta 18
-</Para>
-</ListItem>
-<ListItem>
+</para>
+</listitem>
+<listitem>
 
-<Para>
+<para>
 Samba version 2.0.3
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-</ItemizedList>
+</itemizedlist>
 
-</Para>
+</para>
 
 </chapter>
 
 <chapter id="files">
-<Title>Files in This Package</Title>
+<title>Files in This Package</title>
 
-<Para>
+<para>
 In the package you can find these files:
-</Para>
+</para>
 
-<Para>
-<VariableList>
+<para>
+<variablelist>
 
-<VarListEntry>
-<Term>sis900.c</Term>
-<ListItem>
-<Para>
+<varlistentry>
+<term>sis900.c</term>
+<listitem>
+<para>
 Driver source file in C 
-</Para>
-</ListItem>
-</VarListEntry>
-
-<VarListEntry>
-<Term>sis900.h</Term>
-<ListItem>
-<Para>
+</para>
+</listitem>
+</varlistentry>
+
+<varlistentry>
+<term>sis900.h</term>
+<listitem>
+<para>
 Header file for sis900.c
-</Para>
-</ListItem>
-</VarListEntry>
-
-<VarListEntry>
-<Term>sis900.sgml</Term>
-<ListItem>
-<Para>
+</para>
+</listitem>
+</varlistentry>
+
+<varlistentry>
+<term>sis900.sgml</term>
+<listitem>
+<para>
 DocBook SGML source of the document
-</Para>
-</ListItem>
-</VarListEntry>
-
-<VarListEntry>
-<Term>sis900.txt</Term>
-<ListItem>
-<Para>
+</para>
+</listitem>
+</varlistentry>
+
+<varlistentry>
+<term>sis900.txt</term>
+<listitem>
+<para>
 Driver document in plain text
-</Para>
-</ListItem>
-</VarListEntry>
+</para>
+</listitem>
+</varlistentry>
 
-</VariableList>
-</Para>
+</variablelist>
+</para>
 </chapter>
 
 <chapter id="install">
- <Title>Installation</Title>
+ <title>Installation</title>
 
-<Para>
+<para>
 Silicon Integrated System Corp. is cooperating closely with core Linux Kernel
 developers. The revisions of SiS 900 driver are distributed by the usuall channels
 for kernel tar files and patches. Those kernel tar files for official kernel and
 patches for kernel pre-release can be download at 
-<ULink URL="http://ftp.kernel.org/pub/linux/kernel/">official kernel ftp site</ULink> 
+<ulink url="http://ftp.kernel.org/pub/linux/kernel/">official kernel ftp site</ulink> 
 and its mirrors.
 The 1.06 revision can be found in kernel version later than 2.3.15 and pre-2.2.14, 
 and 1.07 revision can be found in kernel version 2.4.0.
 If you have no prior experience in networking under Linux, please read
-<ULink URL="http://www.tldp.org/">Ethernet HOWTO</ULink> and
-<ULink URL="http://www.tldp.org/">Networking HOWTO</ULink> available from
+<ulink url="http://www.tldp.org/">Ethernet HOWTO</ulink> and
+<ulink url="http://www.tldp.org/">Networking HOWTO</ulink> available from
 Linux Documentation Project (LDP).
-</Para>
+</para>
 
-<Para>
+<para>
 The driver is bundled in release later than 2.2.11 and 2.3.15 so this 
 is the most easy case. 
 Be sure you have the appropriate packages for compiling kernel source.
@@ -338,63 +340,63 @@
 <filename>sis900.c</filename> and <filename>sis900.h</filename> 
 copied into <filename class="directory">/usr/src/linux/drivers/net/</filename> first.
 There are two alternative ways to install the driver
-</Para>
+</para>
 
-<Sect1>
-<Title>Building the driver as loadable module</Title>
+<sect1>
+<title>Building the driver as loadable module</title>
 
-<Para>
+<para>
 To build the driver as a loadable kernel module you have to reconfigure
 the kernel to activate network support by
-</Para>
+</para>
 
-<Para><screen>
+<para><screen>
 make menuconfig
-</screen></Para>
+</screen></para>
 
-<Para>
+<para>
 Choose <quote>Loadable module support  ---></quote>, 
 then select <quote>Enable loadable module support</quote>.
-</Para>
+</para>
 
-<Para>
+<para>
 Choose <quote>Network Device Support  ---></quote>, select 
 <quote>Ethernet (10 or 100Mbit)</quote>.
 Then select <quote>EISA, VLB, PCI and on board controllers</quote>, 
 and choose <quote>SiS 900/7016 PCI Fast Ethernet Adapter support</quote> 
 to <quote>M</quote>.
-</Para>
+</para>
 
-<Para>
+<para>
 After reconfiguring the kernel, you can make the driver module by
-</Para>
+</para>
 
-<Para><screen>
+<para><screen>
 make modules
-</screen></Para>
+</screen></para>
 
-<Para>
+<para>
 The driver should be compiled with no errors. After compiling the driver,
 the driver can be installed to proper place by
-</Para>
+</para>
 
-<Para><screen>
+<para><screen>
 make modules_install
-</screen></Para>
+</screen></para>
 
-<Para>
+<para>
 Load the driver into kernel by
-</Para>
+</para>
 
-<Para><screen>
+<para><screen>
 insmod sis900
-</screen></Para>
+</screen></para>
 
-<Para>
+<para>
 When loading the driver into memory, some information message can be view by
-</Para>
+</para>
 
-<Para>
+<para>
 <screen>
 dmesg
 </screen>
@@ -404,103 +406,103 @@
 <screen>
 cat /var/log/message
 </screen>
-</Para>
+</para>
 
-<Para>
+<para>
 If the driver is loaded properly you will have messages similar to this:
-</Para>
+</para>
 
-<Para><screen>
+<para><screen>
 sis900.c: v1.07.06  11/07/2000
 eth0: SiS 900 PCI Fast Ethernet at 0xd000, IRQ 10, 00:00:e8:83:7f:a4.
 eth0: SiS 900 Internal MII PHY transceiver found at address 1.
 eth0: Using SiS 900 Internal MII PHY as default
-</screen></Para>
+</screen></para>
 
-<Para>
+<para>
 showing the version of the driver and the results of probing routine.
-</Para>
+</para>
 
-<Para>
+<para>
 Once the driver is loaded, network can be brought up by
-</Para>
+</para>
 
-<Para><screen>
+<para><screen>
 /sbin/ifconfig eth0 IPADDR broadcast BROADCAST netmask NETMASK media TYPE
-</screen></Para>
+</screen></para>
 
-<Para>
+<para>
 where IPADDR, BROADCAST, NETMASK are your IP address, broadcast address and
 netmask respectively. TYPE is used to set medium type used by the device. 
 Typical values are "10baseT"(twisted-pair 10Mbps Ethernet) or "100baseT"
 (twisted-pair 100Mbps Ethernet). For more information on how to configure 
 network interface, please refer to  
-<ULink URL="http://www.tldp.org/">Networking HOWTO</ULink>.
-</Para>
+<ulink url="http://www.tldp.org/">Networking HOWTO</ulink>.
+</para>
 
-<Para>
+<para>
 The link status is also shown by kernel messages. For example, after the
 network interface is activated, you may have the message:
-</Para>
+</para>
 
-<Para><screen>
+<para><screen>
 eth0: Media Link On 100mbps full-duplex
-</screen></Para>
+</screen></para>
 
-<Para>
+<para>
 If you try to unplug the twist pair (TP) cable you will get
-</Para>
+</para>
 
-<Para><screen>
+<para><screen>
 eth0: Media Link Off
-</screen></Para>
+</screen></para>
 
-<Para>
+<para>
 indicating that the link is failed.
-</Para>
-</Sect1>
+</para>
+</sect1>
 
-<Sect1>
-<Title>Building the driver into kernel</Title>
+<sect1>
+<title>Building the driver into kernel</title>
 
-<Para>
+<para>
 If you want to make the driver into kernel, choose <quote>Y</quote> 
 rather than <quote>M</quote> on 
 <quote>SiS 900/7016 PCI Fast Ethernet Adapter support</quote> 
 when configuring the kernel. Build the kernel image in the usual way
-</Para>
+</para>
 
-<Para><screen>
+<para><screen>
 make clean
 
 make bzlilo
-</screen></Para>
+</screen></para>
 
-<Para>
+<para>
 Next time the system reboot, you have the driver in memory.
-</Para>
+</para>
 
-</Sect1>
+</sect1>
 </chapter>
 
 <chapter id="problems">
- <Title>Known Problems and Bugs</Title>
+ <title>Known Problems and Bugs</title>
 
-<Para>
+<para>
 There are some known problems and bugs. If you find any other bugs please 
-mail to <ULink URL="mailto:lcchang@sis.com.tw">lcchang@sis.com.tw</ULink>
+mail to <ulink url="mailto:lcchang@sis.com.tw">lcchang@sis.com.tw</ulink>
 
-<OrderedList>
+<orderedlist>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 AM79C901 HomePNA PHY is not thoroughly tested, there may be some 
 bugs in the <quote>on the fly</quote> change of transceiver. 
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 A bug is hidden somewhere in the receive buffer management code, 
 the bug causes NULL pointer reference in the kernel. This fault is 
 caught before bad things happen and reported with the message:
@@ -509,70 +511,70 @@
 eth0: NULL pointer encountered in Rx ring, skipping 
 </computeroutput>
 
-which can be viewed with <Literal remap="tt">dmesg</Literal> or 
-<Literal remap="tt">cat /var/log/message</Literal>.
-</Para>
-</ListItem>
+which can be viewed with <literal remap="tt">dmesg</literal> or 
+<literal remap="tt">cat /var/log/message</literal>.
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 The media type change from 10Mbps to 100Mbps twisted-pair ethernet 
 by ifconfig causes the media link down.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-</OrderedList>
-</Para>
+</orderedlist>
+</para>
 </chapter>
 
 <chapter id="RHistory">
- <Title>Revision History</Title>
+ <title>Revision History</title>
 
-<Para>
-<ItemizedList>
+<para>
+<itemizedlist>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 November 13, 2000, Revision 1.07, seventh release, 630E problem fixed 
 and further clean up.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 November 4, 1999, Revision 1.06, Second release, lots of clean up
 and optimization.
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-<ListItem>
-<Para>
+<listitem>
+<para>
 August 8, 1999, Revision 1.05, Initial Public Release
-</Para>
-</ListItem>
+</para>
+</listitem>
 
-</ItemizedList>
-</Para>
+</itemizedlist>
+</para>
 </chapter>
 
 <chapter id="acknowledgements">
- <Title>Acknowledgements</Title>
+ <title>Acknowledgements</title>
 
-<Para>
+<para>
 This driver was originally derived form 
-<ULink URL="mailto:becker@cesdis1.gsfc.nasa.gov">Donald Becker</ULink>'s
-<ULink URL="ftp://cesdis.gsfc.nasa.gov/pub/linux/drivers/kern-2.3/pci-skeleton.c"
->pci-skeleton</ULink> and
-<ULink URL="ftp://cesdis.gsfc.nasa.gov/pub/linux/drivers/kern-2.3/rtl8139.c"
->rtl8139</ULink> drivers. Donald also provided various suggestion
+<ulink url="mailto:becker@cesdis1.gsfc.nasa.gov">Donald Becker</ulink>'s
+<ulink url="ftp://cesdis.gsfc.nasa.gov/pub/linux/drivers/kern-2.3/pci-skeleton.c"
+>pci-skeleton</ulink> and
+<ulink url="ftp://cesdis.gsfc.nasa.gov/pub/linux/drivers/kern-2.3/rtl8139.c"
+>rtl8139</ulink> drivers. Donald also provided various suggestion
 regarded with improvements made in revision 1.06.
-</Para>
+</para>
 
-<Para>
+<para>
 The 1.05 revision was created by 
-<ULink URL="mailto:cmhuang@sis.com.tw">Jim Huang</ULink>, AMD 79c901 
-support was added by <ULink URL="mailto:lcs@sis.com.tw">Chin-Shan Li</ULink>.
-</Para>
+<ulink url="mailto:cmhuang@sis.com.tw">Jim Huang</ulink>, AMD 79c901 
+support was added by <ulink url="mailto:lcs@sis.com.tw">Chin-Shan Li</ulink>.
+</para>
 </chapter>
 
 <chapter id="functions">
diff -Nru a/Documentation/DocBook/tulip-user.tmpl b/Documentation/DocBook/tulip-user.tmpl
--- a/Documentation/DocBook/tulip-user.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/tulip-user.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="TulipUserGuide">
  <bookinfo>
@@ -67,7 +69,7 @@
 
 <para>
 For 2.4.x and later kernels, the Linux Tulip driver is available at
-<ULink URL="http://sourceforge.net/projects/tulip/">http://sourceforge.net/projects/tulip/</ULink>
+<ulink url="http://sourceforge.net/projects/tulip/">http://sourceforge.net/projects/tulip/</ulink>
 </para>
 
 <para>
@@ -85,7 +87,7 @@
 
 <para>
 	Additional information on Donald Becker's tulip.c
-	is available at <ULink URL="http://www.scyld.com/network/tulip.html">http://www.scyld.com/network/tulip.html</ULink>
+	is available at <ulink url="http://www.scyld.com/network/tulip.html">http://www.scyld.com/network/tulip.html</ulink>
 </para>
 
   </chapter>
diff -Nru a/Documentation/DocBook/usb.tmpl b/Documentation/DocBook/usb.tmpl
--- a/Documentation/DocBook/usb.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/usb.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,7 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
+
 <book id="Linux-USB-API">
  <bookinfo>
   <title>The Linux-USB Host Side API</title>
diff -Nru a/Documentation/DocBook/via-audio.tmpl b/Documentation/DocBook/via-audio.tmpl
--- a/Documentation/DocBook/via-audio.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/via-audio.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="ViaAudioGuide">
  <bookinfo>
diff -Nru a/Documentation/DocBook/videobook.tmpl b/Documentation/DocBook/videobook.tmpl
--- a/Documentation/DocBook/videobook.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/videobook.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="V4LGuide">
  <bookinfo>
@@ -180,23 +182,23 @@
    <tgroup cols="3" align="left">
    <tbody>
    <row>
-        <entry>VFL_TYPE_RADIO</><entry>/dev/radio{n}</><entry>
+        <entry>VFL_TYPE_RADIO</entry><entry>/dev/radio{n}</entry><entry>
 
         Radio devices are assigned in this block. As with all of these
         selections the actual number assignment is done by the video layer
         accordijng to what is free.</entry>
 	</row><row>
-        <entry>VFL_TYPE_GRABBER</><entry>/dev/video{n}</><entry>
+        <entry>VFL_TYPE_GRABBER</entry><entry>/dev/video{n}</entry><entry>
         Video capture devices and also -- counter-intuitively for the name --
         hardware video playback devices such as MPEG2 cards.</entry>
 	</row><row>
-        <entry>VFL_TYPE_VBI</><entry>/dev/vbi{n}</><entry>
+        <entry>VFL_TYPE_VBI</entry><entry>/dev/vbi{n}</entry><entry>
         The VBI devices capture the hidden lines on a television picture
         that carry further information like closed caption data, teletext
         (primarily in Europe) and now Intercast and the ATVEC internet
         television encodings.</entry>
 	</row><row>
-        <entry>VFL_TYPE_VTX</><entry>/dev/vtx[n}</><entry>
+        <entry>VFL_TYPE_VTX</entry><entry>/dev/vtx[n}</entry><entry>
         VTX is 'Videotext' also known as 'Teletext'. This is a system for
         sending numbered, 40x25, mostly textual page images over the hidden
         lines. Unlike the /dev/vbi interfaces, this is for 'smart' decoder 
@@ -301,25 +303,25 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-        <entry>name</><entry>The device text name. This is intended for the user.</>
+        <entry>name</entry><entry>The device text name. This is intended for the user.</entry>
 	</row><row>
-        <entry>channels</><entry>The number of different channels you can tune on
+        <entry>channels</entry><entry>The number of different channels you can tune on
                         this card. It could even by zero for a card that has
                         no tuning capability. For our simple FM radio it is 1. 
                         An AM/FM radio would report 2.</entry>
 	</row><row>
-        <entry>audios</><entry>The number of audio inputs on this device. For our
+        <entry>audios</entry><entry>The number of audio inputs on this device. For our
                         radio there is only one audio input.</entry>
 	</row><row>
-        <entry>minwidth,minheight</><entry>The smallest size the card is capable of capturing
+        <entry>minwidth,minheight</entry><entry>The smallest size the card is capable of capturing
 		        images in. We set these to zero. Radios do not
                         capture pictures</entry>
 	</row><row>
-        <entry>maxwidth,maxheight</><entry>The largest image size the card is capable of
+        <entry>maxwidth,maxheight</entry><entry>The largest image size the card is capable of
                                       capturing. For our radio we report 0.
 				</entry>
 	</row><row>
-        <entry>type</><entry>This reports the capabilities of the device, and
+        <entry>type</entry><entry>This reports the capabilities of the device, and
                         matches the field we filled in in the struct
                         video_device when registering.</entry>
     </row>
@@ -375,26 +377,26 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-        <entry>int tuner</><entry>The number of the tuner in question</entry>
+        <entry>int tuner</entry><entry>The number of the tuner in question</entry>
    </row><row>
-        <entry>char name[32]</><entry>A text description of this tuner. "FM" will do fine.
+        <entry>char name[32]</entry><entry>A text description of this tuner. "FM" will do fine.
                         This is intended for the application.</entry>
    </row><row>
-        <entry>u32 flags</>
+        <entry>u32 flags</entry>
         <entry>Tuner capability flags</entry>
    </row>
    <row>
-        <entry>u16 mode</><entry>The current reception mode</entry>
+        <entry>u16 mode</entry><entry>The current reception mode</entry>
 
    </row><row>
-        <entry>u16 signal</><entry>The signal strength scaled between 0 and 65535. If
+        <entry>u16 signal</entry><entry>The signal strength scaled between 0 and 65535. If
                         a device cannot tell the signal strength it should
                         report 65535. Many simple cards contain only a 
                         signal/no signal bit. Such cards will report either
                         0 or 65535.</entry>
 
    </row><row>
-        <entry>u32 rangelow, rangehigh</><entry>
+        <entry>u32 rangelow, rangehigh</entry><entry>
                         The range of frequencies supported by the radio
                         or TV. It is scaled according to the VIDEO_TUNER_LOW
                         flag.</entry>
@@ -408,20 +410,20 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-	<entry>VIDEO_TUNER_PAL</><entry>A PAL TV tuner</entry>
+	<entry>VIDEO_TUNER_PAL</entry><entry>A PAL TV tuner</entry>
 	</row><row>
-        <entry>VIDEO_TUNER_NTSC</><entry>An NTSC (US) TV tuner</entry>
+        <entry>VIDEO_TUNER_NTSC</entry><entry>An NTSC (US) TV tuner</entry>
 	</row><row>
-        <entry>VIDEO_TUNER_SECAM</><entry>A SECAM (French) TV tuner</entry>
+        <entry>VIDEO_TUNER_SECAM</entry><entry>A SECAM (French) TV tuner</entry>
 	</row><row>
-        <entry>VIDEO_TUNER_LOW</><entry>
+        <entry>VIDEO_TUNER_LOW</entry><entry>
              The tuner frequency is scaled in 1/16th of a KHz
              steps. If not it is in 1/16th of a MHz steps
 	</entry>
 	</row><row>
-        <entry>VIDEO_TUNER_NORM</><entry>The tuner can set its format</entry>
+        <entry>VIDEO_TUNER_NORM</entry><entry>The tuner can set its format</entry>
 	</row><row>
-        <entry>VIDEO_TUNER_STEREO_ON</><entry>The tuner is currently receiving a stereo signal</entry>
+        <entry>VIDEO_TUNER_STEREO_ON</entry><entry>The tuner is currently receiving a stereo signal</entry>
         </row>
     </tbody>
     </tgroup>
@@ -431,13 +433,13 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-                <entry>VIDEO_MODE_PAL</><entry>PAL Format</entry>
+                <entry>VIDEO_MODE_PAL</entry><entry>PAL Format</entry>
    </row><row>
-                <entry>VIDEO_MODE_NTSC</><entry>NTSC Format (USA)</entry>
+                <entry>VIDEO_MODE_NTSC</entry><entry>NTSC Format (USA)</entry>
    </row><row>
-                <entry>VIDEO_MODE_SECAM</><entry>French Format</entry>
+                <entry>VIDEO_MODE_SECAM</entry><entry>French Format</entry>
    </row><row>
-                <entry>VIDEO_MODE_AUTO</><entry>A device that does not need to do
+                <entry>VIDEO_MODE_AUTO</entry><entry>A device that does not need to do
                                         TV format switching</entry>
    </row>
     </tbody>
@@ -582,32 +584,32 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-   <entry>audio</><entry>The input the user wishes to query</>
+   <entry>audio</entry><entry>The input the user wishes to query</entry>
    </row><row>
-   <entry>volume</><entry>The volume setting on a scale of 0-65535</>
+   <entry>volume</entry><entry>The volume setting on a scale of 0-65535</entry>
    </row><row>
-   <entry>base</><entry>The base level on a scale of 0-65535</>
+   <entry>base</entry><entry>The base level on a scale of 0-65535</entry>
    </row><row>
-   <entry>treble</><entry>The treble level on a scale of 0-65535</>
+   <entry>treble</entry><entry>The treble level on a scale of 0-65535</entry>
    </row><row>
-   <entry>flags</><entry>The features this audio device supports
+   <entry>flags</entry><entry>The features this audio device supports
    </entry>
    </row><row>
-   <entry>name</><entry>A text name to display to the user. We picked 
-                        "Radio" as it explains things quite nicely.</>
+   <entry>name</entry><entry>A text name to display to the user. We picked 
+                        "Radio" as it explains things quite nicely.</entry>
    </row><row>
-   <entry>mode</><entry>The current reception mode for the audio
+   <entry>mode</entry><entry>The current reception mode for the audio
 
                 We report MONO because our card is too stupid to know if it is in
                 mono or stereo. 
    </entry>
    </row><row>
-   <entry>balance</><entry>The stereo balance on a scale of 0-65535, 32768 is
-                        middle.</>
+   <entry>balance</entry><entry>The stereo balance on a scale of 0-65535, 32768 is
+                        middle.</entry>
    </row><row>
-   <entry>step</><entry>The step by which the volume control jumps. This is
+   <entry>step</entry><entry>The step by which the volume control jumps. This is
                         used to help make it easy for applications to set 
-                        slider behaviour.</>   
+                        slider behaviour.</entry>   
    </row>
    </tbody>
    </tgroup>
@@ -617,15 +619,15 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-                <entry>VIDEO_AUDIO_MUTE</><entry>The audio is currently muted. We
+                <entry>VIDEO_AUDIO_MUTE</entry><entry>The audio is currently muted. We
                                         could fake this in our driver but we
                                         choose not to bother.</entry>
    </row><row>
-                <entry>VIDEO_AUDIO_MUTABLE</><entry>The input has a mute option</entry>
+                <entry>VIDEO_AUDIO_MUTABLE</entry><entry>The input has a mute option</entry>
    </row><row>
-                <entry>VIDEO_AUDIO_TREBLE</><entry>The  input has a treble control</entry>
+                <entry>VIDEO_AUDIO_TREBLE</entry><entry>The  input has a treble control</entry>
    </row><row>
-                <entry>VIDEO_AUDIO_BASS</><entry>The input has a base control</entry>
+                <entry>VIDEO_AUDIO_BASS</entry><entry>The input has a base control</entry>
    </row>
    </tbody>
    </tgroup>
@@ -635,13 +637,13 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-                <entry>VIDEO_SOUND_MONO</><entry>Mono sound</entry>
+                <entry>VIDEO_SOUND_MONO</entry><entry>Mono sound</entry>
    </row><row>
-                <entry>VIDEO_SOUND_STEREO</><entry>Stereo sound</entry>
+                <entry>VIDEO_SOUND_STEREO</entry><entry>Stereo sound</entry>
    </row><row>
-                <entry>VIDEO_SOUND_LANG1</><entry>Alternative language 1 (TV specific)</entry>
+                <entry>VIDEO_SOUND_LANG1</entry><entry>Alternative language 1 (TV specific)</entry>
    </row><row>
-                <entry>VIDEO_SOUND_LANG2</><entry>Alternative language 2 (TV specific)</entry>
+                <entry>VIDEO_SOUND_LANG2</entry><entry>Alternative language 2 (TV specific)</entry>
    </row>
    </tbody>
    </tgroup>
@@ -866,37 +868,37 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-<entry>VID_TYPE_CAPTURE</><entry>We support image capture</>
+<entry>VID_TYPE_CAPTURE</entry><entry>We support image capture</entry>
 </row><row>
-<entry>VID_TYPE_TELETEXT</><entry>A teletext capture device (vbi{n])</>
+<entry>VID_TYPE_TELETEXT</entry><entry>A teletext capture device (vbi{n])</entry>
 </row><row>
-<entry>VID_TYPE_OVERLAY</><entry>The image can be directly overlaid onto the
-                                frame buffer</>
+<entry>VID_TYPE_OVERLAY</entry><entry>The image can be directly overlaid onto the
+                                frame buffer</entry>
 </row><row>
-<entry>VID_TYPE_CHROMAKEY</><entry>Chromakey can be used to select which parts
-                                of the image to display</>
+<entry>VID_TYPE_CHROMAKEY</entry><entry>Chromakey can be used to select which parts
+                                of the image to display</entry>
 </row><row>
-<entry>VID_TYPE_CLIPPING</><entry>It is possible to give the board a list of
-                                rectangles to draw around. </>
+<entry>VID_TYPE_CLIPPING</entry><entry>It is possible to give the board a list of
+                                rectangles to draw around. </entry>
 </row><row>
-<entry>VID_TYPE_FRAMERAM</><entry>The video capture goes into the video memory
+<entry>VID_TYPE_FRAMERAM</entry><entry>The video capture goes into the video memory
                                 and actually changes it. Applications need
                                 to know this so they can clean up after the
-                                card</>
+                                card</entry>
 </row><row>
-<entry>VID_TYPE_SCALES</><entry>The image can be scaled to various sizes,
-                                rather than being a single fixed size.</>
+<entry>VID_TYPE_SCALES</entry><entry>The image can be scaled to various sizes,
+                                rather than being a single fixed size.</entry>
 </row><row>
-<entry>VID_TYPE_MONOCHROME</><entry>The capture will be monochrome. This isn't a 
+<entry>VID_TYPE_MONOCHROME</entry><entry>The capture will be monochrome. This isn't a 
                                 complete answer to the question since a mono
                                 camera on a colour capture card will still
-                                produce mono output.</>
+                                produce mono output.</entry>
 </row><row>
-<entry>VID_TYPE_SUBCAPTURE</><entry>The card allows only part of its field of
+<entry>VID_TYPE_SUBCAPTURE</entry><entry>The card allows only part of its field of
                                 view to be captured. This enables
                                 applications to avoid copying all of a large
                                 image into memory when only some section is
-                                relevant.</>
+                                relevant.</entry>
     </row>
     </tbody>
     </tgroup>
@@ -1207,18 +1209,18 @@
    <tbody>
    <row>
 
-   <entry>channel</><entry>The channel number we are selecting</entry>
+   <entry>channel</entry><entry>The channel number we are selecting</entry>
    </row><row>
-   <entry>name</><entry>The name for this channel. This is intended
+   <entry>name</entry><entry>The name for this channel. This is intended
                    to describe the port to the user.
                    Appropriate names are therefore things like
                    "Camera" "SCART input"</entry>
    </row><row>
-   <entry>flags</><entry>Channel properties</entry>
+   <entry>flags</entry><entry>Channel properties</entry>
    </row><row>
-   <entry>type</><entry>Input type</entry>
+   <entry>type</entry><entry>Input type</entry>
    </row><row>
-   <entry>norm</><entry>The current television encoding being used
+   <entry>norm</entry><entry>The current television encoding being used
                    if relevant for this channel.
     </entry>
     </row>
@@ -1229,9 +1231,9 @@
     <tgroup cols="2" align="left">
     <tbody>
     <row>
-        <entry>VIDEO_VC_TUNER</><entry>Channel has a tuner.</entry>
+        <entry>VIDEO_VC_TUNER</entry><entry>Channel has a tuner.</entry>
    </row><row>
-        <entry>VIDEO_VC_AUDIO</><entry>Channel has audio.</entry>
+        <entry>VIDEO_VC_AUDIO</entry><entry>Channel has audio.</entry>
     </row>
     </tbody>
     </tgroup>
@@ -1240,11 +1242,11 @@
     <tgroup cols="2" align="left">
     <tbody>
     <row>
-        <entry>VIDEO_TYPE_TV</><entry>Television input.</entry>
+        <entry>VIDEO_TYPE_TV</entry><entry>Television input.</entry>
    </row><row>
-        <entry>VIDEO_TYPE_CAMERA</><entry>Fixed camera input.</entry>
+        <entry>VIDEO_TYPE_CAMERA</entry><entry>Fixed camera input.</entry>
    </row><row>
-	<entry>0</><entry>Type is unknown.</entry>
+	<entry>0</entry><entry>Type is unknown.</entry>
     </row>
     </tbody>
     </tgroup>
@@ -1253,13 +1255,13 @@
     <tgroup cols="2" align="left">
     <tbody>
     <row>
-        <entry>VIDEO_MODE_PAL</><entry>PAL encoded Television</entry>
+        <entry>VIDEO_MODE_PAL</entry><entry>PAL encoded Television</entry>
    </row><row>
-        <entry>VIDEO_MODE_NTSC</><entry>NTSC (US) encoded Television</entry>
+        <entry>VIDEO_MODE_NTSC</entry><entry>NTSC (US) encoded Television</entry>
    </row><row>
-        <entry>VIDEO_MODE_SECAM</><entry>SECAM (French) Television </entry>
+        <entry>VIDEO_MODE_SECAM</entry><entry>SECAM (French) Television </entry>
    </row><row>
-        <entry>VIDEO_MODE_AUTO</><entry>Automatic switching, or format does not
+        <entry>VIDEO_MODE_AUTO</entry><entry>Automatic switching, or format does not
                                 matter</entry>
     </row>
     </tbody>
@@ -1339,14 +1341,14 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-   <entry>GREY</><entry>Linear greyscale. This is for simple cameras and the
-                        like</>
+   <entry>GREY</entry><entry>Linear greyscale. This is for simple cameras and the
+                        like</entry>
    </row><row>
-   <entry>RGB565</><entry>The top 5 bits hold 32 red levels, the next six bits 
-                        hold green and the low 5 bits hold blue. </>
+   <entry>RGB565</entry><entry>The top 5 bits hold 32 red levels, the next six bits 
+                        hold green and the low 5 bits hold blue. </entry>
    </row><row>
-   <entry>RGB555</><entry>The top bit is clear. The red green and blue levels
-                        each occupy five bits.</>
+   <entry>RGB555</entry><entry>The top bit is clear. The red green and blue levels
+                        each occupy five bits.</entry>
     </row>
     </tbody>
     </tgroup>
@@ -1477,32 +1479,32 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-        <entry>width</><entry>The width in pixels of the desired image. The card
-                        may use a smaller size if this size is not available</>
+        <entry>width</entry><entry>The width in pixels of the desired image. The card
+                        may use a smaller size if this size is not available</entry>
 	</row><row>
-        <entry>height</><entry>The height of the image. The card may use a smaller
-                        size if this size is not available.</>
+        <entry>height</entry><entry>The height of the image. The card may use a smaller
+                        size if this size is not available.</entry>
 	</row><row>
-        <entry>x</><entry>   The X position of the top left of the window. This
+        <entry>x</entry><entry>   The X position of the top left of the window. This
                         is in pixels relative to the left hand edge of the
                         picture. Not all cards can display images aligned on
                         any pixel boundary. If the position is unsuitable
                         the card adjusts the image right and reduces the
-                        width.</>
+                        width.</entry>
 	</row><row>
-        <entry>y</><entry>   The Y position of the top left of the window. This
+        <entry>y</entry><entry>   The Y position of the top left of the window. This
                         is counted in pixels relative to the top edge of the
                         picture. As with the width if the card cannot
                         display  starting on this line it will adjust the
-                        values.</>
+                        values.</entry>
 	</row><row>
-        <entry>chromakey</><entry>The colour (expressed in RGB32 format) for the
-                        chromakey colour if chroma keying is being used. </>
+        <entry>chromakey</entry><entry>The colour (expressed in RGB32 format) for the
+                        chromakey colour if chroma keying is being used. </entry>
 	</row><row>
-        <entry>clips</><entry>An array of rectangles that must not be drawn
-			over.</>
+        <entry>clips</entry><entry>An array of rectangles that must not be drawn
+			over.</entry>
 	</row><row>
-        <entry>clipcount</><entry>The number of clips in this array.</>
+        <entry>clipcount</entry><entry>The number of clips in this array.</entry>
     </row>
     </tbody>
     </tgroup>
@@ -1514,11 +1516,11 @@
    <tgroup cols="2" align="left">
    <tbody>
    <row>
-        <entry>x, y</><entry>Co-ordinates relative to the display</>
+        <entry>x, y</entry><entry>Co-ordinates relative to the display</entry>
 	</row><row>
-        <entry>width, height</><entry>Width and height in pixels</>
+        <entry>width, height</entry><entry>Width and height in pixels</entry>
 	</row><row>
-        <entry>next</><entry>A spare field for the application to use</>
+        <entry>next</entry><entry>A spare field for the application to use</entry>
     </row>
     </tbody>
     </tgroup>
diff -Nru a/Documentation/DocBook/wanbook.tmpl b/Documentation/DocBook/wanbook.tmpl
--- a/Documentation/DocBook/wanbook.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/wanbook.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="WANGuide">
  <bookinfo>
diff -Nru a/Documentation/DocBook/writing_usb_driver.tmpl b/Documentation/DocBook/writing_usb_driver.tmpl
--- a/Documentation/DocBook/writing_usb_driver.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/writing_usb_driver.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="USBDeviceDriver">
  <bookinfo>
diff -Nru a/Documentation/DocBook/z8530book.tmpl b/Documentation/DocBook/z8530book.tmpl
--- a/Documentation/DocBook/z8530book.tmpl	Thu Mar  3 11:42:18 2005
+++ b/Documentation/DocBook/z8530book.tmpl	Thu Mar  3 11:42:18 2005
@@ -1,4 +1,6 @@
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V3.1//EN"[]>
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" []>
 
 <book id="Z85230Guide">
  <bookinfo>
