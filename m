Return-Path: <linux-kernel-owner+w=401wt.eu-S1423162AbWLVApK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423162AbWLVApK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 19:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423143AbWLVApK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 19:45:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:60770 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423162AbWLVApJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 19:45:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=AIg3XW4W8qcoAi+UlG7gsnpMUI5al92M4FhmjPmEloM8xa2BZtt/65Uc71Gov31m61CD+hTdN9v7W51YdKYSDMJAqfQRDEuBXWMW6frgflpaAx2RoEfHP4TL64Z4ANlLc5QmmrVWOKH5Sv8gFUguhQYqZdIrc9U6JNlcn2wTEic=
Date: Fri, 22 Dec 2006 01:45:51 +0100
From: Diego Calleja <diegocg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: "Please report the result to linux-kernel to fix this permanently"
Message-Id: <20061222014551.e268f127.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bug in the bugzilla (http://bugzilla.kernel.org/show_bug.cgi?id=7531) that
is asking to be reported here. The full dmesg (with and without 'pci=assign-busses')
can be found in the link.


[17179574.140000] Boot video device is 0000:01:05.0
[17179574.140000] PCI: Transparent bridge - 0000:00:14.4
[17179574.140000] PCI: Bus #06 (-#09) is hidden behind transparent bridge #05 (-#05) (try 'pci=assign-busses')
[17179574.140000] Please report the result to linux-kernel to fix this permanently
[17179574.140000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[17179574.144000] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
[17179574.144000] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
[17179574.144000] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
[17179574.144000] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
[17179574.144000] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
[17179574.144000] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
[17179574.144000] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
[17179574.144000] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
[17179574.144000] ACPI: Embedded Controller [EC0] (gpe 24) interrupt mode.
[17179574.148000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
[17179574.148000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]

