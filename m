Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUBCE6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 23:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUBCE6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 23:58:54 -0500
Received: from fmr99.intel.com ([192.55.52.32]:8073 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S265871AbUBCE6v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 23:58:51 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: IRQ 9: nobody cared ;_;
Date: Mon, 2 Feb 2004 23:58:46 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8A93@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IRQ 9: nobody cared ;_;
Thread-Index: AcPodqQHMq3/f8wwTdSE4cDeGVeYegBm4kVw
From: "Brown, Len" <len.brown@intel.com>
To: "DaMouse Networks" <damouse@ntlworld.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Feb 2004 04:58:47.0793 (UTC) FILETIME=[685FDE10:01C3EA12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need kernel version -- patched with latest ACPI, or no?
Dmesg -s40000 and a copy of /proc/interrupts please.

Thanks,
-Len


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> DaMouse Networks
> Sent: Saturday, January 31, 2004 10:51 PM
> To: linux-kernel@vger.kernel.org
> Subject: IRQ 9: nobody cared ;_;
> 
> 
> irq 9: nobody cared!
> Call Trace:
>  [<c010d5fe>] __report_bad_irq+0x2a/0x8b
>  [<c010d6e8>] note_interrupt+0x6f/0x9f
>  [<c010da06>] do_IRQ+0x161/0x192
>  [<c0105000>] _stext+0x0/0x64
>  [<c010bd64>] common_interrupt+0x18/0x20
>  [<c010901e>] default_idle+0x0/0x2c
>  [<c0105000>] _stext+0x0/0x64
>  [<c0109047>] default_idle+0x29/0x2c
>  [<c01090b0>] cpu_idle+0x33/0x3c
>  [<c03b6850>] start_kernel+0x19e/0x1de
>  [<c03b640e>] unknown_bootoption+0x0/0xfd
>  
> handlers:
> [<c0207f37>] (acpi_irq+0x0/0x16)
> Disabling IRQ #9
> 
> thats all i got, hope it helps.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
