Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTJXHw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 03:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTJXHw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 03:52:29 -0400
Received: from fmr05.intel.com ([134.134.136.6]:59599 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262081AbTJXHw1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 03:52:27 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Fri, 24 Oct 2003 15:52:21 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720B63@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PM][ACPI] No ACPI interrupts after resume from S1
Thread-Index: AcOZonCyiqzcYDarSiqRH265fRV9mQAYQ5yg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "M?ns Rullg?rd" <mru@users.sourceforge.net>,
       <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Oct 2003 07:52:21.0943 (UTC) FILETIME=[C18E8C70:01C39A03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would you please try patch at http://bugme.osdl.org/show_bug.cgi?id=1409
Thanks,
Luming

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Pavel Machek
Sent: 2003?10?23? 16:24
To: M?ns Rullg?rd; acpi-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1


Hi!


> > working.  Normally, they will generate an ACPI event, that is
> > processed by acpid etc.  After a suspend, each button will work once.
> > If I then close and open the lid, they will work one more time, and so
> > on.  Any way I can help?
> 
> Please specify the type of suspend. The situation I described only occurs
> for S1 (or, echo -n standby, more specifically), and only in certain kernel
> versions.

Find out which versions break it, pay special atetion to
hwsleep.c.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
