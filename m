Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSJIWPq>; Wed, 9 Oct 2002 18:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262267AbSJIWPq>; Wed, 9 Oct 2002 18:15:46 -0400
Received: from n1x6.imsa.edu ([143.195.1.6]:11660 "EHLO mail.imsa.edu")
	by vger.kernel.org with ESMTP id <S262201AbSJIWPp>;
	Wed, 9 Oct 2002 18:15:45 -0400
Date: Wed, 9 Oct 2002 17:21:29 -0500
From: Maciej Babinski <maciej@imsa.edu>
To: linux-kernel@vger.kernel.org
Subject: PCMCIA trouble in 2.5.41
Message-ID: <20021009172129.A20370@imsa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since upgrading from 2.4.19 to 2.5.41, my ISA-PCMCIA bridge is
no longer detected. It is detected as follows in 2.4.19, and also
works in 2.5.7, the only other 2.5 kernel I've tried.

Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe:
  Vadem VG-469 ISA-to-PCMCIA at port 0x3e2 ofs 0x00, 2 sockets
    host opts [0]: none
    host opts [1]: none
    ISA irqs (scanned) = 3 polling interval = 1000 ms
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x2f8-0x2ff 0x378-0x37f 0x3e8-0x3f7 0x460-0x467 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0x0d0000-0x0dffff: clean.

In 2.5.41, loadling the i82356 module results in a "no such device"
message.
