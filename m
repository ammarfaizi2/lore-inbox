Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbTIBPCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 11:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbTIBPCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 11:02:38 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:63706 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263822AbTIBPCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 11:02:11 -0400
Date: Tue, 02 Sep 2003 08:01:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: jon@nanocrew.net
Subject: [Bug 1171] New: Boot hang - ThinkPad T40 
Message-ID: <128580000.1062514884@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Boot hang - ThinkPad T40
    Kernel Version: 2.6.0-test4
            Status: NEW
          Severity: normal
             Owner: len.brown@intel.com
         Submitter: jon@nanocrew.net


Notebook: ThinkPad T40 (2373 94G)

.config, acpidmp output and dsdt patch:
http://nanocrew.net/linux/t40/

Panic during boot:
http://w3studi.informatik.uni-stuttgart.de/~rauar/IMG_1120.JPG

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=98849
https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=93319&action=view

With that patch, the kernel does not panic, but hangs after this:

58 Devices found containing: 58 _STA, 6 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
           Summary: Boot hang - ThinkPad T40
    Kernel Version: 2.6.0-test4
            Status: NEW
          Severity: normal
             Owner: len.brown@intel.com
         Submitter: jon@nanocrew.net


Notebook: ThinkPad T40 (2373 94G)

.config, acpidmp output and dsdt patch:
http://nanocrew.net/linux/t40/

Panic during boot:
http://w3studi.informatik.uni-stuttgart.de/~rauar/IMG_1120.JPG

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=98849
https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=93319&action=view

With that patch, the kernel does not panic, but hangs after this:

58 Devices found containing: 58 _STA, 6 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay


