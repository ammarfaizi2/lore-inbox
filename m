Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129572AbQK1Som>; Tue, 28 Nov 2000 13:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129625AbQK1Soc>; Tue, 28 Nov 2000 13:44:32 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38157 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129572AbQK1So2>; Tue, 28 Nov 2000 13:44:28 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: KERNEL BUG: console not working in linux
Date: 28 Nov 2000 10:14:11 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <900slj$9td$1@cesium.transmeta.com>
In-Reply-To: <E140Pc3-0003AI-00@the-village.bc.nu> <20001128011613.A317@fourier.home.intranet> <3A22EF3D.B97A0965@transmeta.com> <20001128103352.A377@fourier.home.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001128103352.A377@fourier.home.intranet>
By author:    Gianluca Anzolin <g.anzolin@inwind.it>
In newsgroup: linux.dev.kernel
>
> |No, the problem is the utterly braindamaged way the motherboard chose to
> |enable/disable it (*especially* if it's PCI... sheech, port 92h isn't
> |exactly something new in that timeframe.)
> |
> |What PC/motherboard is this, anyway?
> 
> It's an olivetti, but maybe they bought the mainboard elsewhere I don't
> know. Anyway you can find the lspci -xvv in
> http://www.gest.unipd.it/~iig0573/lspci.txt
> 

It's not "an Olivetti", it has a model number and God Knows What.
>From the looks of it they are using a 440FX chipset, which definitely
does not have this problem inherently (and almost certainly handles
port 92h correctly), so whomever wired up this motherboard was even
more of an idiot that I first thought.

If I were you I would take it back and demand a refund.  It isn't a PC
you have there.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
