Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTLRHyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 02:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTLRHyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 02:54:23 -0500
Received: from fmr05.intel.com ([134.134.136.6]:44950 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262015AbTLRHyV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 02:54:21 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Wonderful World of Linux 2.6 - Final
Date: Wed, 17 Dec 2003 23:49:59 -0800
Message-ID: <7F740D512C7C1046AB53446D372001736187D1@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Wonderful World of Linux 2.6 - Final
Thread-Index: AcPFNpGivNUprluYSBiYgLp28m94AgABEwdg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Nick Piggin" <piggin@cyberone.com.au>
Cc: "Joe Pranevich" <jpranevich@kniggit.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
X-OriginalArrivalTime: 18 Dec 2003 07:50:00.0288 (UTC) FILETIME=[89D7F600:01C3C53B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with Nick. Ingo's HT-aware scheduler is not in the 2.6 base.
Also the current scheduler does not distinguish idle logical CPU vs.
idle package, having two active processes on the same package, leaving
the other package idle.

	Jun

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Jeff Garzik
> Sent: Wednesday, December 17, 2003 11:12 PM
> To: Nick Piggin
> Cc: Joe Pranevich; linux-kernel; mingo@redhat.com
> Subject: Re: Wonderful World of Linux 2.6 - Final
> 
> Nick Piggin wrote:
> > I'll just mention that the "Hyperthreading" section is not entirely
> > accurate: the process scheduler is blissfully unaware of HT / SMT
> > presently. It is a must fix item though, and there are a number of
> > different implementations available to solve this.
> 
> 
> Are you sure?  I could have sworn Ingo made the scheduler magically
> HT-friendly...
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
