Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288245AbSA2PRp>; Tue, 29 Jan 2002 10:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289698AbSA2PR0>; Tue, 29 Jan 2002 10:17:26 -0500
Received: from marge.bucknell.edu ([134.82.9.1]:55567 "EHLO mail.bucknell.edu")
	by vger.kernel.org with ESMTP id <S288245AbSA2PRQ>;
	Tue, 29 Jan 2002 10:17:16 -0500
Message-Id: <5.1.0.14.2.20020129095621.02268288@mail.bucknell.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 29 Jan 2002 10:17:14 -0500
To: linux-kernel@vger.kernel.org
From: Brinkley Sprunt <bsprunt@mail.bucknell.edu>
Subject: installing an APIC interrupt handler w/o patching the kernel?
Cc: bsprunt@bucknell.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm developing tools to support the use of the Pentium 4 performance
counters and event-based sampling.  I currently have the tools working
for event-based sampling via the APIC performance counter interrupt.
To setup the handler for the APIC interrupt, I have patched the kernel
in a fashion similar to the approach Mikael Pettersson uses for his
perfctr driver.  However, I would like to avoid patching the kernel
in order to install the handler for the APIC interrupt.  I've attempted
to use request_irq(), free_irq(), prove_irq_on(), and probe_irq_off(),
but these just do not appear to be the appropriate interface for
installing APIC interrupt handlers (is this correct?).

Is there a recommended way to install an APIC interrupt handler without
patching the kernel?

Thanks,

Brink


-----------------------------------
Brinkley Sprunt
Electrical Engineering Department
Bucknell University
Moore Avenue
Lewisburg, PA 17837
Office Phone:   570-577-3397
EE Dept. Phone: 570-577-1234
EE Dept. FAX:   570-577-1822
Email: bsprunt@bucknell.edu
http://www.eg.bucknell.edu/~bsprunt
-----------------------------------

