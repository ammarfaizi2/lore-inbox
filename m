Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVF2Uui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVF2Uui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVF2Uui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:50:38 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:47909 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262633AbVF2Urm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:47:42 -0400
X-IronPort-AV: i="3.94,151,1118034000"; 
   d="scan'208"; a="279735699:sNHT60984726"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver 
Date: Wed, 29 Jun 2005 15:47:38 -0500
Message-ID: <B37DF8F3777DDC4285FA831D366EB9E20730AD@ausx3mps302.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver 
Thread-Index: AcV84CA6mFAEAJvwSJObiFPDwmxVZwAC3c7w
From: <Abhay_Salunke@Dell.com>
To: <Valdis.Kletnieks@vt.edu>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jun 2005 20:47:39.0733 (UTC) FILETIME=[C9F48050:01C57CEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Valdis.Kletnieks@vt.edu [mailto:Valdis.Kletnieks@vt.edu]
> Sent: Wednesday, June 29, 2005 2:24 PM
> To: Salunke, Abhay
> Cc: linux-kernel@vger.kernel.org; greg@kroah.com
> Subject: Re: [RFC][patch 2.6.12-rc3] dell_rbu: Resubmitting patch for
new
> Dell BIOS update driver
> 
> On Wed, 29 Jun 2005 15:26:40 CDT, Abhay Salunke said:
> > This patch adds a new function to firmware_calss.c
> request_firmware_nowait_nohotplug .
> > The dell_rbu driver uses this call to create entries in
> /sys/class/firmware.
> >
> > Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>
> >
> > Thanks
> > Abhay
> > diff -uprN linux-2.6.11.11.orig/Documentation/dell_rbu.txt linux-
> 2.6.11.11.new/Documentation/dell_rbu.txt
> 
> > +This driver enables userspace applications to update the BIOS on
Dell
> servers
> > +(starting from servers sold since 1999), desktops and notebooks
> (starting
> > +from those sold in 2005).
> 
> I may be blind, but I'm not seeing where this code makes a check -
what
> happens
> if I try to run this on my 3-year-old Latitude laptop?
This driver should be able to support both server and client systems...
