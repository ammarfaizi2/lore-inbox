Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271800AbTGRQcz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271763AbTGRQbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:31:43 -0400
Received: from franka.aracnet.com ([216.99.193.44]:7622 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S270255AbTGRQax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:30:53 -0400
Date: Fri, 18 Jul 2003 09:45:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 955] New: Nvidia Nforce2 interrupt handling problems
Message-ID: <10010000.1058546729@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=955

           Summary: Nvidia Nforce2 interrupt handling problems
    Kernel Version: 2.6.0-test1
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: andy-kernel.388488@dustman.net


Distribution: Gentoo

Hardware Environment: Athlon-XP, Nvidia Nforce2 chipset, Radeon 8500 (r200) AGP,
3com 3c920

Software Environment:
AWARD BIOS
gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)
GNU ld version 2.14.90.0.2 20030515 <-- binutils
XFree-4.3.0

Problem Description:

PCI interrupt assignments get weird. With certain boot parameters, you can get
from mostly non-functional to mostly functional. dmesg from several combinations
of parmeters will be attached, but in a nutshell, with local APIC and IO-APIC 
and ACPI enabled in the kernel, a lot of strange things happen, even if you use
noapic and pci=noacpi. Disabling the APIC helps a little, but to be functional
at all, pci=noacpi must be used.

Steps to reproduce:

Will be detailed in the following attachments.


