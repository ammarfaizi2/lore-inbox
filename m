Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbUJ2DCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbUJ2DCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 23:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUJ2C5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 22:57:53 -0400
Received: from fmr12.intel.com ([134.134.136.15]:42420 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S263239AbUJ2Cv6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 22:51:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi)
Date: Fri, 29 Oct 2004 10:51:44 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC000@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi)
Thread-Index: AcS9AWiD4mpW8m6OQUOpWtujqCovZQAX1hkQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: "Brown, Len" <len.brown@intel.com>,
       "Moore, Robert" <robert.moore@intel.com>,
       "Alex Williamson" <alex.williamson@hp.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 29 Oct 2004 02:51:56.0741 (UTC) FILETIME=[40F43F50:01C4BD62]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Wednesday 27 October 2004 10:04 pm, Yu, Luming wrote:
>> On IA64 platform, ACPI interpreter seems to be mandatory for those
>> stuff, but IA32 is not.  So, the ram disk is the generic solution 
>> for loading user space interpreter for boot. 
>
>In two sentences: If you want to play with moving the interpreter
>to user-space, please do so, and do it on ia64, so you have to
>deal with the interesting problems.
>
>And this whole thing is a gigantic tangent that is only distracting
>attention from the real question at hand, namely, Alex's dev_acpi
>patch, which exists today and enables some very interesting new
>functionality.
>

  Yes, I agree Alex's dev_acpi is interesting, which could result in 
the removal of some acpi specific drive such as battery.c, button.c,
fan.c, thermal.c ....   So, I raised the question of userspace ACPI 
interpreter.  Intuitively, userspace is the right place for interpreter.

Thanks,
Luming

