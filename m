Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754231AbWKGQ7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbWKGQ7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965419AbWKGQ7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:59:33 -0500
Received: from nz-out-0102.google.com ([64.233.162.199]:59330 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1754224AbWKGQ7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:59:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pjBpXRFVROb8XfqWNtoSvk6YbOggwCVICnNkLJMpi9PSGauixbYJkccsTRsaEJRYE8Z3P5sQBEQWGfJgHoDZenyL+aFmF+dFyLliW5KxIVnrFqS7Bm4IWkwnoZV+wtEbQphBfXaMPv9opzKIcD/zadm60OZ3UwDXlUSNt3Wj6Jw=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch 5/5]: fix comments style in acpi video.c
Date: Wed, 8 Nov 2006 00:58:24 +0800
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611080058.25355.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 5/5: fix comments style in acpi video.c

signed-off-by: Luming Yu <Luming.yu@intel.com>
---
 video.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1b11a3d..7dbf3a1 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -95,26 +95,26 @@ struct acpi_video_bus_flags {
 };
 
 struct acpi_video_bus_cap {
-	u8 _DOS:1;		/*Enable/Disable output switching */
-	u8 _DOD:1;		/*Enumerate all devices attached to display adapter */
-	u8 _ROM:1;		/*Get ROM Data */
-	u8 _GPD:1;		/*Get POST Device */
-	u8 _SPD:1;		/*Set POST Device */
-	u8 _VPO:1;		/*Video POST Options */
+	u8 _DOS:1;		/* Enable/Disable output switching */
+	u8 _DOD:1;		/* Enumerate all devices attached to display adapter */
+	u8 _ROM:1;		/* Get ROM Data */
+	u8 _GPD:1;		/* Get POST Device */
+	u8 _SPD:1;		/* Set POST Device */
+	u8 _VPO:1;		/* Video POST Options */
 	u8 reserved:2;
 };
 
 struct acpi_video_device_attrib {
 	u32 display_index:4;	/* A zero-based instance of the Display */
-	u32 display_port_attachment:4;	/*This field differenates displays type */
-	u32 display_type:4;	/*Describe the specific type in use */
-	u32 vendor_specific:4;	/*Chipset Vendor Specifi */
-	u32 bios_can_detect:1;	/*BIOS can detect the device */
-	u32 depend_on_vga:1;	/*Non-VGA output device whose power is related to 
-				   the VGA device. */
-	u32 pipe_id:3;		/*For VGA multiple-head devices. */
-	u32 reserved:10;	/*Must be 0 */
-	u32 device_id_scheme:1;	/*Device ID Scheme */
+	u32 display_port_attachment:4;	/* differenates displays type */
+	u32 display_type:4;	/* Describe the specific type in use */
+	u32 vendor_specific:4;	/* Chipset Vendor Specifi */
+	u32 bios_can_detect:1;	/* BIOS can detect the device */
+	u32 depend_on_vga:1;	/* Non-VGA output device whose power */
+				/* is related to the VGA device. */
+	u32 pipe_id:3;		/* For VGA multiple-head devices. */
+	u32 reserved:10;	/* Must be 0 */
+	u32 device_id_scheme:1;	/* Device ID Scheme */
 };
 
 struct acpi_video_enumerated_device {
@@ -147,14 +147,14 @@ struct acpi_video_device_flags {
 };
 
 struct acpi_video_device_cap {
-	u8 _ADR:1;		/*Return the unique ID */
-	u8 _BCL:1;		/*Query list of brightness control levels supported */
-	u8 _BCM:1;		/*Set the brightness level */
+	u8 _ADR:1;		/* Return the unique ID */
+	u8 _BCL:1;		/* Query brightness control levels supported */
+	u8 _BCM:1;		/* Set the brightness level */
 	u8 _BQC:1;		/* Get current brightness level */
-	u8 _DDC:1;		/*Return the EDID for this device */
-	u8 _DCS:1;		/*Return status of output device */
-	u8 _DGS:1;		/*Query graphics state */
-	u8 _DSS:1;		/*Device state set */
+	u8 _DDC:1;		/* Return the EDID for this device */
+	u8 _DCS:1;		/* Return status of output device */
+	u8 _DGS:1;		/* Query graphics state */
+	u8 _DSS:1;		/* Device state set */
 };
 
 struct acpi_video_device_brightness {
