Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUDPPQO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbUDPPQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:16:08 -0400
Received: from fmr06.intel.com ([134.134.136.7]:53135 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263444AbUDPPPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:15:38 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] PCI MSI Kconfig consolidation
Date: Fri, 16 Apr 2004 08:15:25 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240405825A@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] PCI MSI Kconfig consolidation
Thread-Index: AcQjS5hNv+lyEJSmRuiugInxtKTkpQAeOx/w
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>, "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "Grant Grundler" <iod00d@hp.com>
X-OriginalArrivalTime: 16 Apr 2004 15:15:26.0240 (UTC) FILETIME=[A5529A00:01C423C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 2:49 pm, Bjorn Helgaas wrote:

>On Thursday 15 April 2004 2:49 pm, Nguyen, Tom L wrote:
>> Based on your PCI MSI Kconfig consolidation patch, the below patch converts the
>> use of CONFIG_PCI_USE_VECTOR to CONFIG_PCI_MSI. Please let us know your comments.
>
>Looks good to me.  We still have the #ifdefs in drivers/acpi/osl.s, but I
>have a patch outstanding to remove that, since everybody now
>implements acpi_gsi_to_irq().  I'll update my patch if yours goes
>in first.

Good!

Thanks,
Long
