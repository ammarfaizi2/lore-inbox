Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265160AbTLLN6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 08:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbTLLN6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 08:58:00 -0500
Received: from qn-213-73-176-162.quicknet.nl ([213.73.176.162]:7684 "EHLO
	ldm.a") by vger.kernel.org with ESMTP id S265149AbTLLN5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 08:57:08 -0500
From: Dale Mellor <dale@dmellor.dabsol.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16345.51504.583427.499297@l.a>
Date: Fri, 12 Dec 2003 14:57:04 +0100
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: floppy motor spins when floppy module not installed
X-Mailer: VM 7.14 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Floppy motor spins when floppy module not installed.

2. From the moment of bootup, the floppy drive motor spins when the kernel is
   compiled to use the floppy driver as a module and this is not installed (the
   motor stops as soon as the module is installed).

3. Keywords: floppy, module, kernel, boot.

4. Kernel version 2.6.0-test11

5. 

6.

7.

7.1 Gnu C                  3.2.1
    Gnu make               3.80
    util-linux             2.11y
    mount                  2.11y
    module-init-tools      0.9.8
    e2fsprogs              1.28
    reiserfsprogs          3.x.1b
    pcmcia-cs              3.2.5
    PPP                    2.4.2b3
    nfs-utils              1.0.6
    Linux C Library        2.3.2
    Dynamic linker (ldd)   2.3.2
    Procps                 2.0.7
    Net-tools              1.60
    Kbd                    command
    Sh-utils               5.0
    Modules Loaded         ymfpci ac97_codec soundcore pcnet_cs 8390 crc32 ipv6 pegasus


7.2 processor	: 0
    vendor_id	: GenuineTMx86
    cpu family	: 6
    model		: 4
    model name	: Transmeta(tm) Crusoe(tm) Processor TM5600
    stepping	: 3
    cpu MHz		: 595.732
    cache size	: 512 KB
    fdiv_bug	: no
    hlt_bug		: no
    f00f_bug	: no
    coma_bug	: no
    fpu		: yes
    fpu_exception	: yes
    cpuid level	: 1
    wp		: yes
    flags		: fpu vme de pse tsc msr cx8 cmov mmx longrun
    bogomips	: 1085.44


7.3 ymfpci 49280 0 - Live 0xc78ed000
    ac97_codec 18080 1 ymfpci, Live 0xc78d2000
    soundcore 8064 1 ymfpci, Live 0xc78bc000
    pcnet_cs 16484 1 - Live 0xc78d8000
    8390 9824 1 pcnet_cs, Live 0xc78ce000
    crc32 4096 1 8390, Live 0xc78bf000
    ipv6 238400 20 - Live 0xc790f000
    pegasus 21024 0 - Live 0xc78c3000


7.4 0000-001f : dma1
    0020-0021 : pic1
    0040-005f : timer
    0060-006f : keyboard
    0080-008f : dma page reg
    00a0-00a1 : pic2
    00c0-00df : dma2
    00f0-00ff : fpu
    01f0-01f7 : ide0
    02f8-02ff : pcnet_cs
    0300-031f : pcnet_cs
    03c0-03df : vga+
    03f6-03f6 : ide0
    0cf8-0cff : PCI conf1
    1000-100f : 0000:00:07.1
      1000-1007 : ide0
      1008-100f : ide1
    1010-1013 : 0000:00:09.0
    1020-103f : 0000:00:07.2
      1020-103f : uhci_hcd
    1040-105f : 0000:00:07.3
    1080-10bf : 0000:00:09.0
    10c0-10c7 : Sony Programable I/O Device
    1400-14ff : 0000:00:0d.0
    4000-40ff : PCI CardBus #01
    4400-44ff : PCI CardBus #01
    8000-803f : 0000:00:07.3

    00000000-0009b7ff : System RAM
    0009b800-0009ffff : reserved
    000a0000-000bffff : Video RAM area
    000c0000-000c7fff : Video ROM
    000f0000-000fffff : System ROM
    00100000-06feffff : System RAM
      00100000-002b4d37 : Kernel code
      002b4d38-0035ff9f : Kernel data
    06ff0000-06fff7ff : ACPI Tables
    06fff800-06ffffff : ACPI Non-volatile Storage
    10000000-10000fff : 0000:00:0c.0
      10000000-10000fff : yenta_socket
    10400000-107fffff : PCI CardBus #01
    10800000-10bfffff : PCI CardBus #01
    a0000000-a0000fff : card services
    fc000000-fc0fffff : 0000:00:00.0
    fc100000-fc103fff : 0000:00:08.0
    fc104000-fc1047ff : 0000:00:08.0
    fc104800-fc1049ff : 0000:00:0b.0
    fc105000-fc105fff : 0000:00:0d.0
    fc108000-fc10ffff : 0000:00:09.0
      fc108000-fc10ffff : ymfpci
    fd000000-fdffffff : 0000:00:0d.0
    fff80000-ffffffff : reserved


7.5

7.6

7.7

X. Workaround: either install the module and then uninstall it;
                   or kill the penguin ;-)  (sorry, couldn't resist...)
