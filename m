Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbVJSXzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbVJSXzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 19:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbVJSXzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 19:55:36 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:1503 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751643AbVJSXzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 19:55:35 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <greg@kroah.com>
Cc: Grant Coady <gcoady@gmail.com>, Roland Dreier <rolandd@cisco.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_ids: cleanup comments
Date: Thu, 20 Oct 2005 09:55:32 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <64ndl1lf0q1o4hqh23u38i2pd4v9oam8d8@4ax.com>
References: <4eedl1h86sarh1i5g42o7vi21i7v1ece2m@4ax.com> <524q7di40y.fsf@cisco.com> <4356C679.2090600@gmail.com> <20051019222744.GA7855@kroah.com>
In-Reply-To: <20051019222744.GA7855@kroah.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2005 15:27:44 -0700, Greg KH <greg@kroah.com> wrote:

>On Thu, Oct 20, 2005 at 08:19:37AM +1000, Grant Coady wrote:
>> --- linux-2.6.14-rc4-mm1a/include/linux/pci_ids.h	2005-10-17 
>> 15:14:41.000000000 +1000
>
>Patch is linewrapped :(
>
Oops, serves me right for changing mailer and not testing to self, sorry.

Cheers,
Grant
From: Grant Coady <gcoady@gmail.com>

pci_ids.h cleanup: convert // comment to /* comment */

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 pci_ids.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.14-rc4-mm1a/include/linux/pci_ids.h	2005-10-17 15:14:41.000000000 +1000
+++ linux-2.6.14-rc4-mm1b/include/linux/pci_ids.h	2005-10-20 08:12:15.000000000 +1000
@@ -448,7 +448,7 @@
 #define PCI_DEVICE_ID_IBM_ICOM_V2_ONE_PORT_RVX_ONE_PORT_MDM	0x0251
 #define PCI_DEVICE_ID_IBM_ICOM_FOUR_PORT_MODEL	0x252
 
-#define PCI_VENDOR_ID_COMPEX2		0x101a // pci.ids says "AT&T GIS (NCR)"
+#define PCI_VENDOR_ID_COMPEX2		0x101a /* pci.ids says "AT&T GIS (NCR)" */
 #define PCI_DEVICE_ID_COMPEX2_100VG	0x0005
 
 #define PCI_VENDOR_ID_WD		0x101c
@@ -1161,10 +1161,10 @@
 
 #define PCI_VENDOR_ID_INIT		0x1101
 
-#define PCI_VENDOR_ID_CREATIVE		0x1102 // duplicate: ECTIVA
+#define PCI_VENDOR_ID_CREATIVE		0x1102 /* duplicate: ECTIVA */
 #define PCI_DEVICE_ID_CREATIVE_EMU10K1	0x0002
 
-#define PCI_VENDOR_ID_ECTIVA		0x1102 // duplicate: CREATIVE
+#define PCI_VENDOR_ID_ECTIVA		0x1102 /* duplicate: CREATIVE */
 #define PCI_DEVICE_ID_ECTIVA_EV1938	0x8938
 
 #define PCI_VENDOR_ID_TTI		0x1103
@@ -1174,7 +1174,7 @@
 #define PCI_DEVICE_ID_TTI_HPT302	0x0006
 #define PCI_DEVICE_ID_TTI_HPT371	0x0007
 #define PCI_DEVICE_ID_TTI_HPT374	0x0008
-#define PCI_DEVICE_ID_TTI_HPT372N	0x0009	// apparently a 372N variant?
+#define PCI_DEVICE_ID_TTI_HPT372N	0x0009	/* apparently a 372N variant? */
 
 #define PCI_VENDOR_ID_VIA		0x1106
 #define PCI_DEVICE_ID_VIA_8763_0	0x0198
