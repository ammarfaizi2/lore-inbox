Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTFDUMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTFDUMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:12:09 -0400
Received: from fmr05.intel.com ([134.134.136.6]:17652 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264035AbTFDUMH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:12:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: sleep forever in ACPI mode S3
Date: Wed, 4 Jun 2003 13:25:36 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E96F24@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sleep forever in ACPI mode S3
Thread-Index: AcMq1SYuE69phUZCS92fWXqwtcG28gAAd3IQ
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>,
       <linux-kernel@vger.kernel.org>
Cc: <acpi-support@lists.sourceforge.net>
X-OriginalArrivalTime: 04 Jun 2003 20:25:36.0202 (UTC) FILETIME=[74C6B2A0:01C32AD7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: C. Scott Ananian [mailto:cananian@lesser-magoo.lcs.mit.edu] 
> echo 3 > /proc/acpi/sleep
>  appears to work correctly on my IBM Thinkpad X20 -- except that it's
>  impossible to wake the machine back up.
> echo 1 > /proc/acpi/sleep
>  has a similar problem -- ordinary keypresses don't wake the 
> machine --
>  but at least in this case the "power button" will bring the 
> machine back.
>  [neither the lid nor the sleep button do, though.]
> 
> Is this a known problem?  What keypresses are *supposed* to wake the
> machine?  I looked through the code, but it looks like we 
> punt off to the
> ACPI firmware to do the actual sleep -- can anyone enlighten me on the
> intended mechanism behind 'wake-from-sleep'?

Does it start to come back but then not make it, or is it just
unrevivifiable?

In any case, sleep/resume is a work in progress that won't work reliably
in the near-term.

Regards -- Andy
