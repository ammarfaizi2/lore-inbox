Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275102AbTHRVYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275103AbTHRVYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:24:37 -0400
Received: from fmr06.intel.com ([134.134.136.7]:59124 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S275102AbTHRVYc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:24:32 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Update MSI Patches
Date: Mon, 18 Aug 2003 14:24:25 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502401541719@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Update MSI Patches
Thread-Index: AcNlxinoaMp12KdQQROkM6fEWt6GwQACDgUg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Greg Kroah-Hartmann" <greg@kroah.com>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Aug 2003 21:24:26.0651 (UTC) FILETIME=[1A11B6B0:01C365CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003, Zwane Mwaikambo wrote:
>> I make minor modification to the last patch to reduce some duplicate functions,
>> as shown as below. I think this perhaps looks better. What do you think?

> The patch looks fine.

>> +#ifdef CONFIG_PCI_USE_VECTOR
>> +static unsigned int startup_edge_ioapic_vector(unsigned int vector)
>> +{
>> +	int irq = vector_to_irq(vector);
>> +
>> +	return (startup_edge_ioapic_irq(irq));
>> +}

> Tiny nit, Linux coding style is;

> return startup_edge_ioapic_irq(irq);

> But you can queue that change for later.

Good! Thank you for your comments. I will roll your comment on Linux coding style 
for later release.

Thanks,
Long
