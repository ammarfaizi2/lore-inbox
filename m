Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVF2UrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVF2UrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVF2Uq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:46:28 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:65285 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262639AbVF2Up5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:45:57 -0400
X-IronPort-AV: i="3.94,151,1118034000"; 
   d="scan'208"; a="279734874:sNHT61409556"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver 
Date: Wed, 29 Jun 2005 15:45:54 -0500
Message-ID: <B37DF8F3777DDC4285FA831D366EB9E20730AC@ausx3mps302.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver 
Thread-Index: AcV83tRDpT5pGWQTSEmxj9wxZCc5cgAAChow
From: <Abhay_Salunke@Dell.com>
To: <Valdis.Kletnieks@vt.edu>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jun 2005 20:45:55.0420 (UTC) FILETIME=[8BC799C0:01C57CEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Valdis.Kletnieks@vt.edu [mailto:Valdis.Kletnieks@vt.edu]
> Sent: Wednesday, June 29, 2005 2:15 PM
> To: Salunke, Abhay
> Cc: linux-kernel@vger.kernel.org; greg@kroah.com
> Subject: Re: [RFC][patch 2.6.12-rc3] dell_rbu: Resubmitting patch for
new
> Dell BIOS update driver
> 
> On Wed, 29 Jun 2005 15:26:40 CDT, Abhay Salunke said:
> 
> > diff -uprN linux-2.6.11.11.orig/Documentation/dell_rbu.txt linux-
> 2.6.11.11.ne
> w/Documentation/dell_rbu.txt
> > --- linux-2.6.11.11.orig/Documentation/dell_rbu.txt	1969-12-31
> 18:00:00.000
> 000000 -0600
> > +++ linux-2.6.11.11.new/Documentation/dell_rbu.txt	2005-06-29
> 15:18:52.000
> 000000 -0500
> > @@ -0,0 +1,72 @@
> 
> > +The rbu driver needs to have an application which will inform the
BIOS
> to
> > +enable the update in the next system reboot.
> 
> And the API for the userspace application to do that is?  There's a
> comment in
> patch to drivers/firmware/dell_rbu.c that says:
> 
> * contiguous and packetized. Both these methods still require having
some
> * application to set the CMOS bit indicating the BIOS to update itself
> * after a reboot.
> 
> but no hint *which* CMOS bit needs to be tweaked - is the
> drivers/char/nvram.c
> driver sufficient if you know the bit/byte number to set?
> 
I would recommend libsmbios application available at
http://linux.dell.com/libsmbios we are working on updating this page to
include instructions on using this App with dell_rbu. Please check on
this link for any updates. Also the dell_rbu.txt will be updated with
the link to this page once it is complete.

Abhay
