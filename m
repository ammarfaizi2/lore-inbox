Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268390AbTCCFan>; Mon, 3 Mar 2003 00:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268391AbTCCFam>; Mon, 3 Mar 2003 00:30:42 -0500
Received: from franka.aracnet.com ([216.99.193.44]:441 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268390AbTCCFam>; Mon, 3 Mar 2003 00:30:42 -0500
Date: Sun, 02 Mar 2003 21:41:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 430] New: ACPI + PCI are not aware of ISA interrupts in use or required to be in use 
Message-ID: <92810000.1046670065@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=430

           Summary: ACPI + PCI are not aware of ISA interrupts in use or
                    required to be in use
    Kernel Version: 2.5.xx-2.5.63bk5
            Status: NEW
          Severity: normal
             Owner: andrew.grover@intel.com
         Submitter: spstarr@sh0n.net


Distribution: LFS 
Hardware Environment: IBM 300PL 6892-N2U PIII (Katmai) 450Mhz 
Problem Description: ACPI/PCI dont notice ISA irqs used 
 
Steps to reproduce: If I set pci=noacpi I have no IRQ conflicts. However, disabling  
pci=noacpi I get conflicts even though all IRQs are correct and are properly 
allocated. 
 
the /proc/interrupts for when pci=noacpi is set and disabled are identical however 
conflicts are reported by the ISAPnP OSS Soundblaster driver. 
  
PCI routing with ACPI isn't aware of ISA interrupts in use or ISA interrupts required.


