Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269958AbTHFQQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269978AbTHFQQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:16:18 -0400
Received: from fmr02.intel.com ([192.55.52.25]:32740 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S269958AbTHFQQM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:16:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: More 2.4.22pre10 ACPI breakage
Date: Wed, 6 Aug 2003 12:16:07 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FC0C@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: More 2.4.22pre10 ACPI breakage
Thread-Index: AcNbtN2/ljPGLo7kRhiOgsBtrrOlngACeMYAAB2lhhA=
From: "Brown, Len" <len.brown@intel.com>
To: "Feldman, Scott" <scott.feldman@intel.com>,
       "Samuel Flory" <sflory@rackable.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Aug 2003 16:16:10.0250 (UTC) FILETIME=[0C65E6A0:01C35C36]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If it still fails with the latest BIOS (11.0)
http://support.intel.com/support/motherboards/server/se7501br2/

Please be encouraged to file a bug at bugzilla.kernel.org
Component: ACPI
Owner: linux-acpi@unix-os.sc.intel.com
If you can drop in the good/bad dmesg, lspci, and /proc/interrupts,
That would be great.

Thanks,
-Len

Ps. If it is an ACPI interrupt config problem, it should boot also with
pci=noacpi


> -----Original Message-----
> From: Feldman, Scott 
> Sent: Tuesday, August 05, 2003 10:05 PM
> To: Samuel Flory; linux-kernel@vger.kernel.org
> Subject: RE: More 2.4.22pre10 ACPI breakage
> 
> 
> >   It appears that the intel Se7501BR mother is also having 
> > issues with ACPI.  When ACPI support is enable the e1000
> > controller stops working printing "<6>NETDEV WATCHDOG:
> > eth0: transmit timed out".
> 
> Must...have...interrupts.  Confirm by watching 
> /proc/interrupts for that
> ethX.
> 
> -scott
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
