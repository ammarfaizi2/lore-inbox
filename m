Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbUKDLVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbUKDLVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbUKDLUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:20:35 -0500
Received: from sd291.sivit.org ([194.146.225.122]:19929 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262172AbUKDLQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:16:02 -0500
Date: Thu, 4 Nov 2004 12:16:14 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/12] meye: the driver is no longer experimental and depends on PCI
Message-ID: <20041104111613.GM3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2346, 2004-11-02 16:09:26+01:00, stelian@popies.net
  meye: the driver is no longer experimental and depends on PCI
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
--- a/drivers/media/video/Kconfig	2004-11-04 11:28:50 +01:00
+++ b/drivers/media/video/Kconfig	2004-11-04 11:28:50 +01:00
@@ -219,8 +219,8 @@
 	  module will be called zr36120.
 
 config VIDEO_MEYE
-	tristate "Sony Vaio Picturebook Motion Eye Video For Linux (EXPERIMENTAL)"
-	depends on VIDEO_DEV && SONYPI && !HIGHMEM64G
+	tristate "Sony Vaio Picturebook Motion Eye Video For Linux"
+	depends on VIDEO_DEV && PCI && SONYPI && !HIGHMEM64G
 	---help---
 	  This is the video4linux driver for the Motion Eye camera found
 	  in the Vaio Picturebook laptops. Please read the material in
