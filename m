Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUAHQXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265508AbUAHQXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:23:23 -0500
Received: from fmr05.intel.com ([134.134.136.6]:38355 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265376AbUAHQXV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:23:21 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] MSI broke visws build
Date: Thu, 8 Jan 2004 08:22:58 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502401541965@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] MSI broke visws build
Thread-Index: AcPVqJZx8/rp9k8HSX6TNb7vCAK32QAWdXMQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Andrey Panin" <pazke@donpac.ru>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
Cc: <linux-visws@lists.sourceforge.net>
X-OriginalArrivalTime: 08 Jan 2004 16:22:59.0138 (UTC) FILETIME=[AE248220:01C3D603]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wednesday, January 07, 2004 9:27 PM Andrey Panin wrote:

attached patch fixes visws builb which wassss broken by
PCI MSI support merge.

diff -urN -X /usr/share/dontdiff
linux-2.6.0-test3.vanilla/include/asm-i386/mach-visws/irq_vectors.h
linux-2.6.0-test3/include/asm-i386/mach-visws/irq_vectors.h
--- linux-2.6.0-test3.vanilla/include/asm-i386/mach-visws/irq_vectors.h
2004-01-01 17:07:40.000000000 +0300
+++ linux-2.6.0-test3/include/asm-i386/mach-visws/irq_vectors.h
2004-01-07 13:58:44.000000000 +0300
@@ -1,6 +1,8 @@
 #ifndef _ASM_IRQ_VECTORS_H
 #define _ASM_IRQ_VECTORS_H
 
+#define NR_VECTORS 256
+
 /*
  * IDT vectors usable for external interrupt sources start
  * at 0x20:


> Thanks for posting the patch! It looks great.


Best regards,
Long
