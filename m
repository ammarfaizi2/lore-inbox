Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTLDW23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTLDW23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:28:29 -0500
Received: from fmr01.intel.com ([192.55.52.18]:60852 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263584AbTLDW22 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:28:28 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [ACPI] Re: [RFC] enhanced psxface.c error handling
Date: Thu, 4 Dec 2003 14:27:45 -0800
Message-ID: <CFF522B18982EA4481D3A3E23B83141C24B5E7@orsmsx407.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] Re: [RFC] enhanced psxface.c error handling
Thread-Index: AcO6skjBvYbUeXG0RUCrEeMxa9rMlgAA1wXw
From: "Moore, Robert" <robert.moore@intel.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>,
       <acpi-devel@lists.sourceforge.net>
Cc: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Dec 2003 22:27:46.0326 (UTC) FILETIME=[D7771B60:01C3BAB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've made a stab at this in ACPI CA version 20031203.  There are a
couple of additional subtleties to get unwound correctly with no memory
leaks.

It has turned into a bit of spaghetti code, I'm going to restructure it
later.

Bob


> -----Original Message-----
> From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
> admin@lists.sourceforge.net] On Behalf Of Felipe Alfaro Solana
> Sent: Thursday, December 04, 2003 2:00 PM
> To: acpi-devel@lists.sourceforge.net
> Cc: Linux Kernel Mailinglist
> Subject: [ACPI] Re: [RFC] enhanced psxface.c error handling
> 
> On Thu, 2003-12-04 at 17:14, Mihai RUSU wrote:
> 
> > I think you missed the order on this one
> 
> Yep! You're right... thanks!
