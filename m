Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132785AbRDQRor>; Tue, 17 Apr 2001 13:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132796AbRDQRoh>; Tue, 17 Apr 2001 13:44:37 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:25854 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S132785AbRDQRoZ>; Tue, 17 Apr 2001 13:44:25 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE848@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Martin Hamilton'" <martin@net.lut.ac.uk>, linux-kernel@vger.kernel.org
Subject: RE: Linux 2.4.3-ac7 
Date: Tue, 17 Apr 2001 10:41:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Martin Hamilton [mailto:martin@net.lut.ac.uk]
> Pardon me for butting in, but perhaps this is relevant...
> 
> I've seen the odd program which manipulates the ACPI tables/registers
> directly rather than through an ASL compiler then an AML interpreter.
> These appear to use the "magic numbers" which the interpreter would
> eventually spit out.
> 
> Being a newbie on ACPI internals (still ploughing through the 400 page
> 'specification' document), I'm not sure whether there would be nasty
> implications from doing this on a larger scale - e.g. needing to tweak
> those magic numbers for each and every ACPI BIOS implementation.

(BTW, read the ACPI 2.0 spec - it's a lot better)

ACPI is meant to abstract the OS from all the "magic numbers". It's very
possible to do things in a platform-specific way, but if you want to handle
all platforms, you'd end up with something ACPI-like.

> Back in the real world, some people using ACPI BIOSes (e.g. owners of
> recent Sony Vaio boxes like my C1VE) are finding that the legacy APM
> support is losing when they try to do things like suspend to disk.  A
> minimalist ACPI implementation could be just the ticket...

We're working on this. The major issue now is device power management. 

Regards -- Andy

