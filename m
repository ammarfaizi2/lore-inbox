Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131732AbRCUR2F>; Wed, 21 Mar 2001 12:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131737AbRCUR17>; Wed, 21 Mar 2001 12:27:59 -0500
Received: from ns.suse.de ([213.95.15.193]:36879 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131732AbRCUR0v>;
	Wed, 21 Mar 2001 12:26:51 -0500
Date: Wed, 21 Mar 2001 18:34:40 +0100 (CET)
From: egger@suse.de
Reply-To: egger@suse.de
Subject: Re: Only 10 MB/sec with via 82c686b chipset?
To: chromi@cyberspace.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <l03130301b6de66229e10@[192.168.239.101]>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010321182613.85AF354D6@Nicole.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Mar, Jonathan Morton wrote:

> The "blue and white" PowerMac G3 and certain early PowerMac G4s used a
> 66MHz PCI card for graphics in lieu of proper AGP.  66MHz PCI is used
> in certain high-end workstations, as well, but it's not normally found
> on consumer-level devices.
 
> Look at 'lspci -vvv' output for the "66MHz" flag on the devices listed
> there - all the ones in my Duron system leave it unset, except for my
> (very recent and pretty nippy) SCSI controller and (AGP) video card.

 Well, I wasn't talking about 66Mhz nor about 64bit cards but rather 
 normal consumer cards which are specified for 33Mhz.

> That said, *most* PCI devices don't like being overclocked, and it's
> not well known that pushing the system bus also pushes the PCI and ISA
> buses in the same manner.  A friend of mine had *severe* locking
> problems with his system when he inserted his cheap SCSI adapter into
> his overclocked machine, even though the other cards handled it OK
> (relatively speaking - I'm not convinced).  I don't know how far he'd
> overclocked it, but 37MHz kinda rings true.

 Trying to enhance a systems performance by overclocking the bus is
 about the most stupid thing one can do as one ANY of the connected
 devices memory/CPU/chipset/PCI devices/AGP cards (just to name a
 few) have a high probability of failing and all those probabilites
 factor up which basically means that the system is in a unpredictable
 state which is never acceptable for any serious kind of system. 

 Better leave the overclocking of busses to kids who are bored
 by their live.

-- 

Servus,
       Daniel

