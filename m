Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEH4d>; Fri, 5 Jan 2001 02:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAEH4Y>; Fri, 5 Jan 2001 02:56:24 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:20746 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129183AbRAEH4M>; Fri, 5 Jan 2001 02:56:12 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE573@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Michael D. Crawford'" <crawford@goingware.com>,
        linux-kernel@vger.kernel.org
Subject: RE: How to Power off with ACPI/APM?
Date: Thu, 4 Jan 2001 23:56:07 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael D. Crawford [mailto:crawford@goingware.com]
> > How is each of your setups, ie, what is compiled in kernel 
> and what is 
> > a module ? My guess is: 
> > - ACPI+APM in kernel: ACPI wins 
> > - APM in kernel, ACPI module; APM starts, blocks ACPI 
> > - and so on.... 
> 
> Nope.  If they're both in the kernel, APM wins.
 
> Many folks have given me tips on getting power off to work, 
> I'll screw around to
> see if I can get it to go.  But I guess the fact that ACPI 
> exits if APM is
> enabled is a real bug.

Hey, that's not a bug, that's a feature! ;) ACPI and APM cannot both be
active, so we check on init. However, the fact that the help says ACPI
always wins is incorrect, and will be fixed.

Regards -- Andy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
