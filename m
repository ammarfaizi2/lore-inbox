Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290299AbSAXVHV>; Thu, 24 Jan 2002 16:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290300AbSAXVHL>; Thu, 24 Jan 2002 16:07:11 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:12457 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290299AbSAXVHE>; Thu, 24 Jan 2002 16:07:04 -0500
Date: Thu, 24 Jan 2002 22:06:47 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Martin Eriksson <nitrax@giron.wox.org>
cc: Ed Sweetman <ed.sweetman@wmich.edu>, Vojtech Pavlik <vojtech@suse.cz>,
        Timothy Covell <timothy.covell@ashavan.org>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <007801c1a4e4$ee428480$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.40.0201242201480.9957-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Martin Eriksson wrote:

> Well I guess it's very mobo-dependent then. What I remember from the VCool
> program is that it made windows go crazy on me. I dont know exactly what
> happened, just that I removed vcool very quickly.
>
> I just tried the function again, not using vcool, instead *only* enabling
> bit 8 of register 0x52 ("Disconnect Enable When STPGNT Detected") with the
> following results:
>
> * No other (major) load than Winamp: Minor sound skips
> * Winamp when reading from hard disk: Major sound skips
> * Winamp when using distributed.net client: Almost no sound skips (one or
> two on a 4 minute tune)
> * Winamp when using distributed.net & using hard disk: Almost no sound skips
>
> As both the HD controller and soundcard does much DMA, I guess it has some
> connection to DMA transfers on the PCI bus?
>
> OS: Windows 2000 Pro
> Northbridge: VIA KT133
> Southbridge: VIA 686B
> CPU: Athlon(B) 1GHz

i agree that this could be connected with dma transfers ... maybe the
disconnect procedure disturbs dma transfers on slower cpus, where the
disconnect/reconnect procedure takes to long ?
maybe it is realy a metter of the motherboard ? who realy knows ? maybe a
amd/via guru could answer this question ... at the moment i can't answer
it ... and my system isn't affected by this sound skips ... so i even
can'T make testes on it ...
maybe someon with this skips could make some tests ?
disabling/enabling dma , change some timings for pci bus in bios or such
things ?

daniel



# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

