Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVCKSbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVCKSbK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVCKS3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:29:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20497 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261273AbVCKSQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:16:32 -0500
Date: Fri, 11 Mar 2005 19:16:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Dillow <dave@thedillows.org>
Subject: [2.6 patch] drivers/net/typhoon: make a firmware image static
Message-ID: <20050311181625.GH3723@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a nedlessly global firmware image static.

This patch was already ACK'ed by David Dillow.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Feb 2005

--- linux-2.6.11-rc3-mm2-full/drivers/net/typhoon-firmware.h.old	2005-02-16 18:56:23.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/typhoon-firmware.h	2005-02-16 18:56:31.000000000 +0100
@@ -32,7 +32,7 @@
  */ 
 
  /* ver 03.001.008 */
-const u8 typhoon_firmware_image[] = {
+static const u8 typhoon_firmware_image[] = {
 0x54, 0x59, 0x50, 0x48, 0x4f, 0x4f, 0x4e, 0x00, 0x02, 0x00, 0x00, 0x00, 
 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xcb, 0x99, 0xb1, 0xd4, 
 0x4c, 0xb8, 0xd0, 0x4b, 0x32, 0x02, 0xd4, 0xee, 0x73, 0x7e, 0x0b, 0x13, 

