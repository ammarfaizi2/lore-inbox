Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272216AbTHRRxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHRRxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:53:52 -0400
Received: from fmr04.intel.com ([143.183.121.6]:52708 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S272216AbTHRRxr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:53:47 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
Date: Mon, 18 Aug 2003 13:53:39 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC6D@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.0-test3 latest bk hangs when enabling IO-APIC
Thread-Index: AcNlipEEWf8ZRdgtRTGroWKsasLKYQAJsDtA
From: "Brown, Len" <len.brown@intel.com>
To: "Stian Jordet" <liste@jordet.nu>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Aug 2003 17:53:40.0498 (UTC) FILETIME=[A85FE720:01C365B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try booting with pci=noacpi, and if that doesn't work acpi=off
If either of those work, then file in bugzilla with component=ACPI and
assign it to len.brown@intel.com

Thanks,
-Len

> -----Original Message-----
> From: Stian Jordet [mailto:liste@jordet.nu] 
> Sent: Monday, August 18, 2003 9:10 AM
> To: linux-kernel@vger.kernel.org
> Subject: 2.6.0-test3 latest bk hangs when enabling IO-APIC
> 
> 
> Hello,
> 
> latest bk of 2.6.0-test3 hangs with these three lines:
> 
> ENABLING IO-APIC IRQs
> Setting 2 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> 
> And there it stays forever. 2.6.0-test3 worked like a charm. This is a
> Asus CUV265-DLS motherboard. Dual P3.
> 
> Should I file a bugreport at bugzilla?
> 
> Best regards,
> Stian
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
