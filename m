Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275137AbRJAO72>; Mon, 1 Oct 2001 10:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275138AbRJAO7T>; Mon, 1 Oct 2001 10:59:19 -0400
Received: from snowball.fnal.gov ([131.225.81.94]:17427 "EHLO
	snowball.fnal.gov") by vger.kernel.org with ESMTP
	id <S275137AbRJAO7I>; Mon, 1 Oct 2001 10:59:08 -0400
Date: Mon, 1 Oct 2001 09:59:35 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: Marvin Justice <mjustice@austin.rr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
In-Reply-To: <01093015371606.00965@bozo>
Message-ID: <Pine.LNX.4.31.0110010958260.4216-100000@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2001, Marvin Justice wrote:

> The error :
>
> Curious - OSB4 thinks the DMA is still running.
> OSB4 wait exit
>
> appears to occur during the "rewrite" phase of Bonnie++ every time we run it.
> The setup is a Tyan 2515 with a Seagate ST310211A drive. Bonnie ran for ~48
> hours on 2.4.10 without slowdown (I assume this is because the extra check in
> -ac isn't present) but there was some file system corruption after the 1st 24
> hours:
>
> EXT2-fs error (device ide0(3,6)): ext2_free_blocks: Freeing blocks not in
> datazone - block = 2138996092, count = 1
>
> Here's the lspci:
>
> 00:00.0 Host bridge: ServerWorks CNB20LE (rev 06)
> 	Flags: bus master, medium devsel, latency 32
>
> 00:00.1 Host bridge: ServerWorks CNB20LE (rev 06)
> 	Flags: bus master, medium devsel, latency 16
>
> [snip]
>
> 00:0f.0 ISA bridge: ServerWorks OSB4 (rev 50)
> 	Subsystem: ServerWorks OSB4
> 	Flags: bus master, medium devsel, latency 0
>
> 00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master
> SecP PriP])
> 	Flags: bus master, medium devsel, latency 64
> 	I/O ports at ffa0 [size=16]
>
>
> --
> Marvin Justice
> Software Developer
> BOXX Technologies, Inc.
> www.boxxtech.com
> 512-235-6318 (V)
> 412-835-0434 (F)
>

