Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbTHZVcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 17:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTHZVcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 17:32:54 -0400
Received: from smtp4.hy.skanova.net ([195.67.199.133]:14279 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262923AbTHZVcw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 17:32:52 -0400
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: "Ro0tSiEgE LKML" <lkml@ro0tsiege.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Missing natsemi PCI ID
Date: Tue, 26 Aug 2003 23:35:35 +0200
User-Agent: KMail/1.5.9
References: <000501c36c10$c292c120$0500000a@bp>
In-Reply-To: <000501c36c10$c292c120$0500000a@bp>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308262335.35397.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 22.29, Ro0tSiEgE LKML wrote:
> Taken from "lspci -vvv".
> The computer is an HP Pavilion ze4145 notebook. Most of the devices do not
> have corresponding PCI ID's in the kernel, but I am only worried about the
> NIC right now.
>
> 00:12.0 Ethernet controller: National Semiconductor Corporation DP83815
> (MacPhyter) Ethernet Controller
>              Subsystem: Unknown device 3c08:2400
>              Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>              Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>              Interrupt: pin A routed to IRQ 11
>              Region 0: I/O ports at 8c00
>              Region 1: Memory at e0003000 (32-bit, non-prefetchable)
>              Capabilities: [40] Power Management version 2
>                           Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                           Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> Any help would be greatly appreciated, I've had this notebook for 6 months
> and cannot use the network card under Linux. I tested it with Windows and
> OpenBSD and the network card works fine under both.

Have you tried "# modprobe natsemi" ?
Followed by usual network configuration.

What distribution do you use?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
