Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTDELcS (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 06:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbTDELcS (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 06:32:18 -0500
Received: from fep02.superonline.com ([212.252.122.41]:31894 "EHLO
	fep02.superonline.com") by vger.kernel.org with ESMTP
	id S262100AbTDELcR (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 06:32:17 -0500
Message-ID: <3E8EC0F7.6060507@superonline.com>
Date: Sat, 05 Apr 2003 14:41:43 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre7 - hpt366.c does not build
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may need something like this, I think
(from my archives, doesn't have to apply
  cleanly but you get the idea).

=== hpt372n-pci_ids.patch ===
--- linux/include/linux/pci_ids.h.orig	2003-03-11 18:50:01.000000000 +0200
+++ linux/include/linux/pci_ids.h	2003-03-19 16:16:09.000000000 +0200
@@ -975,6 +975,7 @@
  #define PCI_DEVICE_ID_TTI_HPT372	0x0005
  #define PCI_DEVICE_ID_TTI_HPT302	0x0006
  #define PCI_DEVICE_ID_TTI_HPT371	0x0007
+#define PCI_DEVICE_ID_TTI_HPT372N	0x0009
  #define PCI_DEVICE_ID_TTI_HPT374	0x0008

  #define PCI_VENDOR_ID_VIA		0x1106



