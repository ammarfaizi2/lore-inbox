Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTFXQxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTFXQxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:53:38 -0400
Received: from fmr06.intel.com ([134.134.136.7]:58325 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262633AbTFXQxg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:53:36 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI source releases updated (20030619)
Date: Tue, 24 Jun 2003 10:07:40 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E96FC6@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI source releases updated (20030619)
Thread-Index: AcM6YQKkNOlVPWL6TiisltN+ZmcExQAEaxJg
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: <acpi-devel@lists.sourceforge.net>, "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jun 2003 17:07:40.0568 (UTC) FILETIME=[1E9BC180:01C33A73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Udo A. Steinberg [mailto:us15@os.inf.tu-dresden.de] 
> The new ACPI interpreter works much better and seems to 
> mostly solve the
> previous problems I had with ACPI on a Dual-Xeon machine with HT, see
> http://bugme.osdl.org/show_bug.cgi?id=774
> 
> The excessive ACPI interrupts have ceased, but I still get exactly
> 100000 ACPI interrupts during bootup and then no more. Also the ACPI
> interrupt seems to hit the e100 driver unexpectedly.

There's still a problem here, btw, so don't close the bug or anything -
it's just that the interrupt code is noticing we're horribly broken and
turning the interrupt off.

Regards -- Andy
