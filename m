Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262675AbTCPPBt>; Sun, 16 Mar 2003 10:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262674AbTCPPBt>; Sun, 16 Mar 2003 10:01:49 -0500
Received: from franka.aracnet.com ([216.99.193.44]:9378 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262677AbTCPPBs>; Sun, 16 Mar 2003 10:01:48 -0500
Date: Sun, 16 Mar 2003 07:12:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 464] New: 2.5.64: Dell Inspiron 8000 BIOS A04 EMERGENCY SHUTDOWN!
Message-ID: <57820000.1047827557@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=464

           Summary: 2.5.64: Dell Inspiron 8000 BIOS A04 EMERGENCY SHUTDOWN!
    Kernel Version: 2.5.64
            Status: NEW
          Severity: blocking
             Owner: andrew.grover@intel.com
         Submitter: andi@lisas.de


Distribution: Debian unstable
Hardware Environment: Dell Inspiron 8000 notebook, 512MB, ATI 32MB
Software Environment: 2.5.64, gcc 3.2.3
Problem Description:
I just got my new Dell Inspiron 8000 notebook (was defective, but repaired
quickly, by "cleaning" it :-).
I noticed two immediate emergency shutdowns on 2.5.64/ACPI, which I initially
suspected to be "notebook still slightly defective" issues.
But after several days of very reliable operation on 2.4.21/APM (it seems to do
passive management via CPU throttling), I'm quite
convinced that it's a problem of the 2.5.64 kernel ACPI management instead.
This notebook still has BIOS A04, despite a very advanced version of A21 (!)
being available (the previous owner obviously wasn't very eager to keep
it up to date).
In other words, I suspect that BIOS A04 has some "quirks" that cause 2.5.64
to horribly misinterprete ACPI thermal management.
I really don't think Dell would have released that machine if it had shown such
fatal power management behaviour on Windows, so I guess we do have an ACPI
management problem of some sort in Linux with slightly less kosher BIOS
implementations.
I intend to update my BIOS to the latest version VERY soon now (I don't feel
safe running such an old and broken BIOS version), so please try to handle this
bug report IMMEDIATELY.

Steps to reproduce:
I don't want to describe that here, since I really don't intend to put my
machine through yet another emergency shutdown...
You need to produce some high CPU load, though...

I was unsure of which Severity to assign to this bug (high or blocking),
but I believe we really shouldn't release 2.6 with any sorts of hardware damage
potential (at least as long as we can avoid it), so I made it blocking, for
a good reason, I think.


