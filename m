Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262012AbTCLWHB>; Wed, 12 Mar 2003 17:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbTCLWHB>; Wed, 12 Mar 2003 17:07:01 -0500
Received: from fmr01.intel.com ([192.55.52.18]:19455 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262012AbTCLWG7> convert rfc822-to-8bit;
	Wed, 12 Mar 2003 17:06:59 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [BK PATCH] 2.4 ACPI update
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Wed, 12 Mar 2003 14:17:43 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56401338DA2@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BK PATCH] 2.4 ACPI update
Thread-Index: AcLo33C08k55EZSWSB2LijIYBFyowAAA9JnQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Grover, Andrew" <andrew.grover@intel.com>,
       "Christoph Hellwig" <hch@infradead.org>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Mar 2003 22:17:43.0751 (UTC) FILETIME=[34023570:01C2E8E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree. 

The file was replaced basically by 
	arch/i386/kernel/acpi.c
and part of the code in acpitable.c was reused there. 

Thanks,
Jun

> -----Original Message-----
> From: Grover, Andrew
> Sent: Wednesday, March 12, 2003 1:35 PM
> To: Christoph Hellwig
> Cc: Marcelo Tosatti; linux-kernel@vger.kernel.org
> Subject: RE: [BK PATCH] 2.4 ACPI update
> 
> > From: Christoph Hellwig [mailto:hch@infradead.org]
> > On Wed, Mar 12, 2003 at 11:12:43AM -0800, Grover, Andrew wrote:
> > >  arch/i386/kernel/acpitable.c            |  554 ----
> > >  arch/i386/kernel/acpitable.h            |  260 --
> >
> > No reason to remove this.
> 
> The ACPI patch implements CPU-enum-only support in exactly the same way
> that 2.5 does, so my thinking was that this code is no longer needed.
> 
> If this *has* been the roadblock to 2.4 patch acceptance for the past 16
> months, then obviously I would be willing to revert that cset and keep
> it, but I do think the patch does keep the functionality provided by
> those files - i.e. the ability to get ACPI table parsing for cpu enum
> without adding the interpreter to the kernel image.
> 
> Regards -- Andy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
