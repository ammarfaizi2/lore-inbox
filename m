Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbTCTCnH>; Wed, 19 Mar 2003 21:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbTCTCnG>; Wed, 19 Mar 2003 21:43:06 -0500
Received: from fmr02.intel.com ([192.55.52.25]:6107 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261306AbTCTCnF> convert rfc822-to-8bit; Wed, 19 Mar 2003 21:43:05 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: P4 3.06Ghz Hyperthreading with 2.4.20?
Date: Wed, 19 Mar 2003 18:53:54 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB564013393B7@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: P4 3.06Ghz Hyperthreading with 2.4.20?
Thread-Index: AcLugQjl5Np7ACULRcykNlsSf8zmeQACW37wAABYeoA=
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "James Wright" <james@jigsawdezign.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Mar 2003 02:53:54.0409 (UTC) FILETIME=[F1C83590:01C2EE8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the typo. APIC -> ACPI.

> -----Original Message-----
> From: Nakajima, Jun
> Sent: Wednesday, March 19, 2003 6:51 PM
> To: James Wright; linux-kernel@vger.kernel.org
> Subject: RE: P4 3.06Ghz Hyperthreading with 2.4.20?
> 
> You need to apply the ACPI patch: http://sourceforge.net/projects/acpi and
> *configure* APIC.
> 
> The 2.4 kernel depends on the MPS table for all but logical processors. If
> MPS table is not present, it will fall back to UP.
> 
> Thanks,
> Jun
> 
> > -----Original Message-----
> > From: James Wright [mailto:james@jigsawdezign.com]
> > Sent: Wednesday, March 19, 2003 5:34 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: P4 3.06Ghz Hyperthreading with 2.4.20?
> >
> > Hello,
> >
> >    I have kernel 2.4.20 with a single P4 3.06Ghz CPU and Asus P4G8X
> > motherboard
> > (with the Intel E7205) Chipset. I have enabled Hyperthreading in the
> BIOS
> > options,
> > compiled in SMP & ACPI support, and also tried adding "acpismp=force" to
> > my lilo
> > kernel cmdline, but it just doesn't seem to detect the second Logical
> CPU.
> > My
> > current theory is that this is bcos Linux expects the motherboard to be
> an
> > SMP
> > item (as with the Xeon boards) but this board is a Single processor
> board,
> > ansd
> > doesn't have an MP table, but the cpu info is held in the ACPI
> tables.?!?
> >
> > I have tried installing 2.5.65 but can't get past the compile due to
> > compile-time
> > errors... Is this a known problem? SHall i just disable Hyperthreading
> > until a new
> > kernel release?
> >
> >
> > Thanks,
> > James
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
