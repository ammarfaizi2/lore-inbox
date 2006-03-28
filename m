Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWC1W7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWC1W7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWC1W7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:59:04 -0500
Received: from [198.99.130.12] ([198.99.130.12]:18627 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964784AbWC1W7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:59:03 -0500
Message-Id: <200603282300.k2SN04Gp022967@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/10] UML - Fix initcall return values
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Mar 2006 18:00:04 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of UML initcalls were improperly returning 1.
Also removed any nearby emacs formatting comments.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-mm/arch/um/drivers/daemon_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/daemon_kern.c	2006-03-23 16:40:20.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/daemon_kern.c	2006-03-28 17:11:14.000000000 -0500
@@ -95,18 +95,7 @@ static struct transport daemon_transport
 static int register_daemon(void)
 {
 	register_transport(&daemon_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_daemon);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/drivers/mcast_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/mcast_kern.c	2006-03-28 17:11:00.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/mcast_kern.c	2006-03-28 17:13:59.000000000 -0500
@@ -124,18 +124,7 @@ static struct transport mcast_transport 
 static int register_mcast(void)
 {
 	register_transport(&mcast_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_mcast);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/drivers/pcap_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/pcap_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.16-mm/arch/um/drivers/pcap_kern.c	2006-03-28 17:11:50.000000000 -0500
@@ -106,18 +106,7 @@ static struct transport pcap_transport =
 static int register_pcap(void)
 {
 	register_transport(&pcap_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_pcap);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/drivers/slip_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/slip_kern.c	2006-03-23 16:40:20.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/slip_kern.c	2006-03-28 17:13:59.000000000 -0500
@@ -93,18 +93,7 @@ static struct transport slip_transport =
 static int register_slip(void)
 {
 	register_transport(&slip_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_slip);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/drivers/slirp_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/slirp_kern.c	2006-03-28 15:55:30.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/slirp_kern.c	2006-03-28 17:13:59.000000000 -0500
@@ -116,18 +116,7 @@ static struct transport slirp_transport 
 static int register_slirp(void)
 {
 	register_transport(&slirp_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_slirp);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/ubd_kern.c	2006-03-28 15:55:30.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/ubd_kern.c	2006-03-28 17:12:55.000000000 -0500
@@ -891,7 +891,7 @@ int ubd_driver_init(void){
 			     SA_INTERRUPT, "ubd", ubd_dev);
 	if(err != 0)
 		printk(KERN_ERR "um_request_irq failed - errno = %d\n", -err);
-	return(err);
+	return 0;
 }
 
 device_initcall(ubd_driver_init);
Index: linux-2.6.16-mm/arch/um/os-Linux/drivers/ethertap_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/drivers/ethertap_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/drivers/ethertap_kern.c	2006-03-28 17:13:40.000000000 -0500
@@ -102,18 +102,7 @@ static struct transport ethertap_transpo
 static int register_ethertap(void)
 {
 	register_transport(&ethertap_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_ethertap);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.16-mm/arch/um/os-Linux/drivers/tuntap_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/drivers/tuntap_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/drivers/tuntap_kern.c	2006-03-28 17:13:57.000000000 -0500
@@ -87,18 +87,7 @@ static struct transport tuntap_transport
 static int register_tuntap(void)
 {
 	register_transport(&tuntap_transport);
-	return(1);
+	return 0;
 }
 
 __initcall(register_tuntap);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

