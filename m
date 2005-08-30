Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVH3T7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVH3T7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVH3T7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:59:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:52937 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932182AbVH3T7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:59:37 -0400
Subject: [Fwd: [tpmdd-devel] [PATCH]
	linux-2.6.13/drivers/char/tpm/tpm_atmel.c on ICH6]
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: tpmdd-devel@lists.sourceforge.net, pmhahn@titan.lahn.de, akpm@osdl.org
Content-Type: text/plain
Date: Tue, 30 Aug 2005 14:57:36 -0500
Message-Id: <1125431856.8180.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables more new hardware.

ACKed-by: Kylene Hall <kjhall@us.ibm.com>

-------- Forwarded Message --------
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: tpmdd-devel@lists.sourceforge.net
Subject: [tpmdd-devel] [PATCH] linux-2.6.13/drivers/char/tpm/tpm_atmel.c
on ICH6
Date: Tue, 30 Aug 2005 10:28:22 +0200
Hello!

While installing Debian on our new IBM X41 Tablet, I tried briefly to
use the built-in Atmel TPM. The Athmel TPM is also located on the
LPC-bus of the ICH6. To make it work I had to apply the following patch:

Signed-off-by: Philipp Matthias Hahn <pmhahn@titan.lahn.de>

--- linux-2.6.13-rc7/drivers/char/tpm/tpm_atmel.c.orig	2005-08-26 15:21:21.000000000 +0200
+++ linux-2.6.13-rc7/drivers/char/tpm/tpm_atmel.c	2005-08-26 13:22:45.000000000 +0200
@@ -206,6 +206,9 @@ static struct pci_device_id tpm_pci_tbl[
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
 	{PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6LPC)},
 	{0,}

BYtE
Philipp

