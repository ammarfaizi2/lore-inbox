Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbTLMHg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 02:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTLMHg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 02:36:27 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:40334 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264485AbTLMHg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 02:36:26 -0500
Date: Fri, 12 Dec 2003 23:36:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1677] New: Kernel hang with message "ACPI: IRQ9	SCI: Level Trigger"
Message-ID: <1361920000.1071300981@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1677

           Summary: Kernel hang with message "ACPI: IRQ9 SCI: Level Trigger"
    Kernel Version: 2.6.0-test11
            Status: NEW
          Severity: normal
             Owner: len.brown@intel.com
         Submitter: gustavo.michels@ig.com.br


Distribution: Gentoo Linux
Hardware Environment: Laptop HP Pavilion ze4430us

Problem Description: Kernel hangs with message "ACPI: IRQ9 SCI: Level Trigger". 
Only bootable if acpi=off is passed as option. I applied the latest patch 
available (acpi-20031203-2.6.0-test11.diff.bz2) with the same results.

I tried pci=noacpi and noapic also, no luck.

Also tried 2.6.0.test10-mm1, same thing.


