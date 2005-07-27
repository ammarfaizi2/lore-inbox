Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVG0XXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVG0XXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVG0XUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:20:43 -0400
Received: from fmr16.intel.com ([192.55.52.70]:33723 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261216AbVG0XUH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:20:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI buttons in 2.6.12-rc4-mm2
Date: Wed, 27 Jul 2005 19:19:48 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300428CA9E@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI buttons in 2.6.12-rc4-mm2
Thread-Index: AcWTAFfwCKFNd5znSkuMk7ijioHF6wAAB6rA
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <thecwin@gmail.com>, <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jul 2005 23:19:50.0236 (UTC) FILETIME=[AFB9B1C0:01C59301]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Len Brown <len.brown@intel.com> wrote:
>> I deleted /proc/acpi/button on purpose,
>> did you have a use for those files?
>
>Can we put it back, please?

of course.

>We cannot go ripping out stuff which applications and users 
>are currently using without quite a lot of preparation.

Agreed.  Although the implementation of the /proc lid status
file is fundamentally flawed in that even its name in /proc
is able to change and thus it is a totally bogus user-space API,
it was not thoughtful to delete it.

I'm open to suggestions on how to approach this transition.
I can make ACPI_PROC a static build option -- what else
can I do to ease the transition in this, our stable release?

thanks,
-Len
