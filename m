Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131093AbQL1RaK>; Thu, 28 Dec 2000 12:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131118AbQL1RaA>; Thu, 28 Dec 2000 12:30:00 -0500
Received: from thales.casi.polymtl.ca ([132.207.73.32]:23053 "EHLO
	thales.casi.polymtl.ca") by vger.kernel.org with ESMTP
	id <S131093AbQL1R3n>; Thu, 28 Dec 2000 12:29:43 -0500
Date: Thu, 28 Dec 2000 13:00:23 -0500 (EST)
From: <fpieraut@casi.polymtl.ca>
To: linux-kernel@vger.kernel.org
Subject: Activating APIC on single processor
Message-ID: <Pine.LNX.4.10.10012281242140.9711-100000@thales.casi.polymtl.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I try to activate APIC interrruption on a single processor(PIII) with
kernel2.4.0-test11.

I activate APIC interruption with the configuration of linux kernel
2.4.0test-11. In the linux kernel configuration under processor type and
features I activate "APIC and IO-APIC support on uniprocessor",  and I
desactivate "Symmetric multi-processing support". The only way I found to
check APIC activation is looking into /proc/interrupts, no "IO-APIC" can
be found there. So I read IO-APIC.txt and I suppose there sould be
conflicts with IRQ of my PCI cards. So I remove all my PCI cards and still
have no APIC interrupt. 
Is there another way to check APIC activation? 
Am-I doing to right things to activate IO-APIC?

Any help will be very  appreciate
    
Francis Pieraut

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
