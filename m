Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129476AbQKXPfD>; Fri, 24 Nov 2000 10:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129657AbQKXPey>; Fri, 24 Nov 2000 10:34:54 -0500
Received: from [195.77.234.5] ([195.77.234.5]:3849 "HELO ntdes.cirsa.com")
        by vger.kernel.org with SMTP id <S129476AbQKXPel>;
        Fri, 24 Nov 2000 10:34:41 -0500
Message-ID: <01C0562F.DAD0C2E0@wsi_joan.UNIDESA_RD>
From: I+D <jbertran@cirsa.com>
To: "'rminnich@lanl.gov'" <rminnich@lanl.gov>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Booting AMD Elan520 without BIOS
Date: Fri, 24 Nov 2000 16:01:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

I'm trying to boot an AMD Elan520 board without bios
with kernel 2.4.0-test10 configured for i486 and PCI direct access.
This kernel boots correctly from HD using the bios provided with the 
evaluation board but kernel 2.4.0-test8 and previous hang
after "Ok booting the kernel".
  Currently I have the SDRam configured, the PCI peripherals
initialized (with AMD code), the GDT loaded in RAM and the CPU
in 32 bit mode. The empty_zero_page is configured with the RAM
and a command line (using code from LinuxBios and kernel startup).
I decompress directly from rom to 0x100000 the
kernel image and then I jump there.
	The last message I see is "Calibrating delay loop"
(I see this thaks to the Jtag debugger for Elan520 because
I haven't configured the VGA board yet).

May somebody enumerate the requirements to boot the kernel
I mean the peripherals,system configuration etc.

			Thankyou.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
