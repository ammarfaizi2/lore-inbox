Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264086AbUCZQdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 11:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbUCZQdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 11:33:15 -0500
Received: from fmr06.intel.com ([134.134.136.7]:33152 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264080AbUCZQdM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 11:33:12 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: RE[PATCH]2.6.5-rc2 MSI Support for IA64
Date: Fri, 26 Mar 2004 08:32:44 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502404058199@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RE[PATCH]2.6.5-rc2 MSI Support for IA64
Thread-Index: AcQS3vdvs8JHXDcRRzq5Y+IbQMv3OQAb8Jjg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: <davidm@napali.hpl.hp.com>, <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
       <greg@kroah.com>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 26 Mar 2004 16:32:45.0539 (UTC) FILETIME=[F7E2B330:01C4134F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 26 Mar 2004, Zwane Mwaikambo wrote:

>> >> +#ifndef CONFIG_IA64
>> >>  int assign_irq_vector(int irq)
>> >>  {
>> >
>> >We could define this as a weak function with arch override.
>>
>> Agree. We are thinking of replacing the semantics of assign_irq_vector()
>> in existing arch/i386/kernel/io_apic.c with the semantics of
>> assign_irq_vector() in drivers/pci/msi.c. With this way,
>
>There shouldn't be a problem replacing it on i386, the only thing is
>perhaps making sure it's marked __init when we're not using
>CONFIG_PCI_USE_VECTOR

Good! Will make changes on next update. Regarding __init, thanks for your
suggestion. 

Thanks,
Long
