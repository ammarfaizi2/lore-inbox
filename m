Return-Path: <linux-kernel-owner+w=401wt.eu-S1751930AbWLNBW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWLNBW1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbWLNBW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:22:27 -0500
Received: from web50109.mail.yahoo.com ([206.190.38.37]:28564 "HELO
	web50109.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751930AbWLNBW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:22:26 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 20:22:26 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pvITUS/77MX+QdbxqnzjeWE+oBPFQP9PsAVE0juLpZxzCj5i6HUCvflYccwq53X/VSzMge6/Bv7bA509xgCYf/y/J/cwi9zwpFdHxUhCR62hP+3kUSaDAgnhHMY8fftmp5Rey2oMVkQMj9NspYabkEVKektxF4MhLMrqSZ6fHjs=  ;
Message-ID: <20061214011545.74035.qmail@web50109.mail.yahoo.com>
X-YMail-OSG: V0w69X4VM1mzkv.0NzrKfZU07wOiNUDEQCPwrEZB8Bgw7gah4yKxSFAO7Yose.bpWTUk79ljY76TXMpfc_n1dsGzIKsm1.MIwICow_tuPej_FJZXp6IbkYcSZlUD.R4LqeC6yGlg2g--
Date: Wed, 13 Dec 2006 17:15:45 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 1/1] pci_ids: Add AMD K8 Northbridge devices
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Thompson  <norsk5@xmission.com>

This patch adds the following 2 AMD K8 Northbridge devices:

the ADDRMAP 
the MEMCTL devices

to the pci_ids.h file

Signed-off-by: Doug Thompson  <norsk5@xmission.com>

---


Index: linux-2.6.19/include/linux/pci_ids.h
===================================================================
--- linux-2.6.19.orig/include/linux/pci_ids.h
+++ linux-2.6.19/include/linux/pci_ids.h
@@ -479,6 +479,8 @@
 
 #define PCI_VENDOR_ID_AMD		0x1022
 #define PCI_DEVICE_ID_AMD_K8_NB		0x1100
+#define PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP	0x1101
+#define PCI_DEVICE_ID_AMD_K8_NB_MEMCTL	0x1102
 #define PCI_DEVICE_ID_AMD_K8_NB_MISC	0x1103
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001


