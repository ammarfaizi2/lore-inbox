Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131860AbQKKSB3>; Sat, 11 Nov 2000 13:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131861AbQKKSBT>; Sat, 11 Nov 2000 13:01:19 -0500
Received: from pmcl.ph.utexas.edu ([128.83.155.100]:25607 "EHLO
	pmcl.ph.utexas.edu") by vger.kernel.org with ESMTP
	id <S131860AbQKKSBN>; Sat, 11 Nov 2000 13:01:13 -0500
Date: Sat, 11 Nov 2000 11:15:12 -0600 (EST)
From: <michael@pmcl.ph.utexas.edu>
To: "Allen, David B" <David.B.Allen@chase.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: intel etherpro100 on 2.2.18p21 vs 2.2.18p17
In-Reply-To: <93BA6BFC5E48D4118A8200508B6BBC4924AB7A@sf1-mail01.hamquist.com>
Message-ID: <Pine.LNX.4.10.10011111111390.18876-100000@pmcl.ph.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have the SUPER 370DL3 SuperMicro boards w/ the integrated Intel NIC,
unfortunately a warm boot does not help.  The problem also seems to happen
when I turn on the alias ip feature in the kernel under network options.


On Fri, 10 Nov 2000, Allen, David B wrote:

> FWIW, I have a dual-proc SuperMicro motherboard P3DM3 with integrated
> Adaptec SCSI and Intel 8255x built-in NIC.
> 
> Sometimes on a cold boot I get the "kernel: eth0: card reports no RX
> buffers" that repeats, but if I follow it with a warm boot the message
> doesn't appear (even on subsequent warm boots).  So this is definitely
> reproducible, but it doesn't happen every time.
> 
> I can't offer much more than that, but at least you know you're not the only
> one experiencing this.
> 
>  -----Original Message-----
> From: 	michael@pmcl.ph.utexas.edu [mailto:michael@pmcl.ph.utexas.edu] 
> Sent:	Friday, November 10, 2000 9:00 AM
> To:	linux-kernel@vger.kernel.org
> Subject:	intel etherpro100 on 2.2.18p21 vs 2.2.18p17
> 
> We have several Supermicro 370DL3 boards (scsi, built into epro100, dual
> pentium iii) - which are giving the following ethernet card error on
> 2.2.18p21, but not on 2.2.18p17.  This error has happened on 3 out of 4
> boards with this configuration.
> 
> Oct 18 12:17:34 db1 kernel: eth0: card reports no RX buffers. 
> The above message repeats itself and the ethernet card does not work.
> 
> On bootup:
> <SNIP>
> Oct 18 12:17:34 db1 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
> http://cesdis.gsfc.nasa.gov/linux/drivers/eepro10$
> Oct 18 12:17:34 db1 kernel: eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31
> Modified by Andrey V. Savochkin <saw@saw.sw.c$
> Oct 18 12:17:34 db1 kernel: eth0: Intel PCI EtherExpress Pro100 82557,
> 00:30:48:21:2F:9E, I/O at 0xd400, IRQ 31.
> Oct 18 12:17:34 db1 kernel:   Board assembly 000000-000, Physical
> connectors present: RJ45
> Oct 18 12:17:34 db1 kernel:   Primary interface chip i82555 PHY #1.
> Oct 18 12:17:34 db1 kernel:   General self-test: passed.
> Oct 18 12:17:34 db1 kernel:   Serial sub-system self-test: passed.
> Oct 18 12:17:34 db1 kernel:   Internal registers self-test: passed.
> Oct 18 12:17:34 db1 kernel:   ROM checksum self-test: passed (0x04f4518b).
> Oct 18 12:17:34 db1 kernel:   Receiver lock-up workaround activated.
> <SNIP>
> Oct 18 12:17:34 db1 kernel: eth0: card reports no RX buffers. 
> 
> 
> I believe this has been an ongoing issue for these intel nics?
> 
> --Michael
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
