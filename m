Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbTCWA5Z>; Sat, 22 Mar 2003 19:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbTCWA5Z>; Sat, 22 Mar 2003 19:57:25 -0500
Received: from franka.aracnet.com ([216.99.193.44]:42386 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262194AbTCWA5X>; Sat, 22 Mar 2003 19:57:23 -0500
Date: Sat, 22 Mar 2003 17:08:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 489] New: Boot hang on HP ZE4145
Message-ID: <370310000.1048381704@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=489

           Summary: Boot hang on HP ZE4145
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: andrew.grover@intel.com
         Submitter: andrew.grover@intel.com


Reported by Sean Gillespie <dragonbyte@dragonspyre.net>

I am unable to get ACPI working on my ZE4145 Laptop (BIOS Rev KA.M1.20).  I
have tried 2.4.18 w/ ACPI patch, 2.4.21 w/ ACPI patch, 2.5.53, 2.5.64, and
2.5.65 and have tried pci=acpi and pci=nobios and get the same error with
each one.  I enabled Debug mode for ACPI and this basically what happens.
ACPI: Subsystem revision <varies with kernel>, ACPI Tables successfully
acquired, Parsing all Control Methods, Table [DSDT] - 724 Objects 51 Devices
222 Methods 17 Regions, Parsing all Control Methods, Table [SSDT] 0 Objects,
0 Devices, 0 Methods, 0 Regions, ACPI Namespace successfully loaded at root
c03c89bc, evxfevnt-0073 [04] acpi_enable : Transition to ACPI mode
successful, evgpe-0262:  GPE Block0 defined as GPE0 to GPE63.  The system
then halts <no oops, no panic> on this line <shown as it appears>
Executing all Device _STA and_INI methods:....


