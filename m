Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQJZTxs>; Thu, 26 Oct 2000 15:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129505AbQJZTxi>; Thu, 26 Oct 2000 15:53:38 -0400
Received: from gwyn.tux.org ([207.96.122.8]:13756 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id <S129121AbQJZTxZ>;
	Thu, 26 Oct 2000 15:53:25 -0400
Date: Thu, 26 Oct 2000 15:53:23 -0400
From: Timothy Ball <timball@tux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: VM-global-2.2.18pre17-7
Message-ID: <20001026155323.E12432@gwyn.tux.org>
In-Reply-To: <Pine.LNX.4.21.0010251633080.3324-100000@freak.distro.conectiva> <39F84B64.5935C12@ovh.net> <39F8566D.51561CB3@profmakx.de> <39F85A09.DA88452F@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.7i
In-Reply-To: <39F85A09.DA88452F@ovh.net>; from oles@ovh.net on Thu, Oct 26, 2000 at 06:21:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 06:21:29PM +0200, octave klaba wrote:
> 
> 
> > > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.
> > let me guess: intel eepro100 or similar??
> yeap
> 
> 00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
>         Subsystem: Asustek Computer, Inc.: Unknown device 1043
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 8 min, 56 max, 64 set, cache line size 08
>         Interrupt: pin A routed to IRQ 20
>         Region 0: Memory at fd000000 (32-bit, non-prefetchable)
>         Region 1: I/O ports at d800
>         Region 2: Memory at fc800000 (32-bit, non-prefetchable)
>         Capabilities: <available only to root>
> 
> > Well known problem with that one. dont know if its fully fixed ... With
> > 2.4.0-test9-pre3 it doesnt happen on my machine ...
> we have 1-2 servers running 2.4.0-test9 and we got this error ...

I get similar eth0 hangs using a 3c59x. Though outside of rebooting I
have no clue how to get networking going again.

--timball

-- 
	Send mail with subject "send pgp key" for public key.
pub  1024R/CFF85605 1999-06-10 Timothy L. Ball <timball@sheergenius.com>
     Key fingerprint = 8A 8E 64 D6 21 C0 90 29  9F D6 1E DC F8 18 CB CD
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
