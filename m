Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbRDTSZU>; Fri, 20 Apr 2001 14:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135887AbRDTSZL>; Fri, 20 Apr 2001 14:25:11 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:28940 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S131809AbRDTSZC>; Fri, 20 Apr 2001 14:25:02 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256A34.00651F1C.00@smtpnotes.altec.com>
Date: Fri, 20 Apr 2001 13:24:34 -0500
Subject: PCMCIA problem in 2.4.4-pre5
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Since upgrading to 2.4.4-pre5 my PCMCIA wireless network card no longer works.
Here's a snippet of the dmesg output from 2.4.4-pre5:

Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
ds: no socket drivers loaded!


However, it works fine in both 2.4.4-pre4 and 2.4.3-ac10.  Here's the relevant
portion of the dmesg output from 2.4.3-ac10:

Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe:
  Intel i82365sl B step ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
    host opts [0]: none
    host opts [1]: none
    ISA irqs (scanned) = 3,4,5,7,9,10 polling interval = 1000 ms


after which comes a series of cs IO port and memory probes.  BTW, I'm using
pcmcia-cs-3.1.25.

Wayne


