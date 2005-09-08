Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVIHWWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVIHWWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVIHWWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:22:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:32702 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965036AbVIHWWx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:53 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Added DS2433 driver - family id update.
In-Reply-To: <11262181621949@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:42 -0700
Message-Id: <11262181623003@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Added DS2433 driver - family id update.

Work by Ben Gardner <bgardner@wabtec.com>.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a3d65f254274567daa89d8b99ab3d481d60fcaef
tree 4cdd137a5ec753c04a8da41a0f61ef034c92fe84
parent 80895392c83e54653540e72e7d40573aac7ee690
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 11 Aug 2005 17:27:50 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:27 -0700

 drivers/w1/w1_family.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -31,6 +31,7 @@
 #define W1_FAMILY_SMEM_81	0x81
 #define W1_THERM_DS18S20 	0x10
 #define W1_THERM_DS1822  	0x22
+#define W1_EEPROM_DS2433  	0x23
 #define W1_THERM_DS18B20 	0x28
 
 #define MAXNAMELEN		32

