Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289854AbSA2UAb>; Tue, 29 Jan 2002 15:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289855AbSA2UAU>; Tue, 29 Jan 2002 15:00:20 -0500
Received: from c007-h013.c007.snv.cp.net ([209.228.33.220]:16850 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S289854AbSA2UAD>;
	Tue, 29 Jan 2002 15:00:03 -0500
X-Sent: 29 Jan 2002 19:59:06 GMT
Message-ID: <3C56FF07.304AFB48@bigfoot.com>
Date: Tue, 29 Jan 2002 11:59:03 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.21pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Krzysztof Oledzki <ole@ans.pl>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.21pre2; ide_set_handler; DMA timeout
In-Reply-To: <Pine.LNX.4.33.0201291122500.16536-100000@dark.pcgames.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > smp kernel: HPT366: onboard version of chipset, pin1=1 pin2=2
> > smp kernel: PCI: HPT366: Fixing interrupt 18 pin 2 to ZERO
> > smp kernel: HPT366: IDE controller on PCI bus 00 dev 99
> > smp kernel: HPT366: chipset revision 1
> > smp kernel: HPT366: not 100% native mode: will probe irqs later
> > smp kernel:     ide4: BM-DMA at 0xc000-0xc007, BIOS settings: hdi:pio, hdj:pio
> <CIACH>
> > smp kernel: hdi: FUJITSU MPE3084AE, ATA DISK drive
> 
> Is this FUJITSU (hdi) connected to HPT? If so, the problem may be in hpt

Yes.

> driver. You may check some more recent version of IDE backport from
> 2.4.x: http://www.ans.pl/ide/testing - the latest is ide.2.2.21.01282002-Ole,
> but the new version of hpt driver has not been yet backported. I'm going
> to do it tomorrow.

I'll test the backport hpt driver when available.

Thanks.
--
