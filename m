Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUARIBr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 03:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266265AbUARIBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 03:01:46 -0500
Received: from fmr06.intel.com ([134.134.136.7]:23505 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266252AbUARIBp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 03:01:45 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] More info on VP6 panics
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Sun, 18 Jan 2004 16:01:35 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720CF5@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] More info on VP6 panics
Thread-Index: AcPcxoXczFtRUU69RbawLrDFZ5NqyAA0Lh4A
From: "Yu, Luming" <luming.yu@intel.com>
To: "Ian Pilcher" <i.pilcher@comcast.net>, <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Jan 2004 08:01:35.0685 (UTC) FILETIME=[4B235F50:01C3DD99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>ve that the panic occurs anywhere in the ACPI 
> code.  From
> what I can tell, the transition to ACPI mode causes the idle thread on
> the other processor to panic.
> 
> I believe that I have identified the line of code that triggers the
> panic.  It is the actual transition to ACPI mode at
> drivers/acpi/hardware/hwacpi.c, line 143.  If I insert an 
> infinite loop
> before the call to acpi_os_write_port, the boot process simply hangs.
> If I move the loop below the call to acpi_os_write_port, I 
> get the same
> old panic message.
>

That experiment can only tell that there is no panic displayed on you
screen
before the infinite loop.

I did remember this error, but I cannot find out other emails about this
issue.
Did you file it on bugzilla.kernel.org? It will help us a lot.

Thanks,
Luming

