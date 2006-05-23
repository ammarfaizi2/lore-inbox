Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWEWURq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWEWURq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWEWURp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:17:45 -0400
Received: from mga03.intel.com ([143.182.124.21]:6736 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751241AbWEWURp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:17:45 -0400
X-IronPort-AV: i="4.05,161,1146466800"; 
   d="scan'208"; a="40551609:sNHT878194828"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: APIC error on CPUx
Date: Tue, 23 May 2006 16:16:25 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB686E5B4@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: APIC error on CPUx
Thread-Index: AcZ+NF1NzrGQFQAxSYGe5ob1evRCugAb+E/w
From: "Brown, Len" <len.brown@intel.com>
To: "Vladimir Dvorak" <dvorakv@vdsoft.org>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 May 2006 20:16:26.0333 (UTC) FILETIME=[C4D058D0:01C67EA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://www.abclinuxu.cz/images/hosting/sr1200.pdf

An Intel SCB2, a Dual P3/Serverworks board....
Run it in the default IOAPIC mode and ignore the warnings.
No, upgrading the kernel will almost certainly not make
any difference.
My note about running with "noapic" was mis-guided --
I didn't realize this was an SMP server board.

Curious, however that you can't boot in IOAPIC mode with acpi=off.
I thought that in that era they still had MPS support.  You might
take a peek at the BIOS setup options.  dmesg will also mention
MPS if it is there.  However, even if you succeeded in booting
in acpi=off MPS IOAPIC mode, I would not expect it to have an
effect on the warnings you see.

cheers,
-Len
