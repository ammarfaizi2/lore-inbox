Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270795AbRIVNnC>; Sat, 22 Sep 2001 09:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271005AbRIVNmw>; Sat, 22 Sep 2001 09:42:52 -0400
Received: from CPE-61-9-150-176.vic.bigpond.net.au ([61.9.150.176]:8946 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S270795AbRIVNmh>; Sat, 22 Sep 2001 09:42:37 -0400
Message-ID: <3BAC94BF.EFCA9404@eyal.emu.id.au>
Date: Sat, 22 Sep 2001 23:40:15 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
In-Reply-To: <20010921134402.A975@gerg.ca> <20010921205356.A1104@suse.cz> <20010921150806.A2453@gerg.ca> <20010921154903.A621@gerg.ca> <20010921215622.A1282@suse.cz> <20010921164304.A545@gerg.ca> <20010922100451.A2229@suse.cz> <OE3183UV8wAddX47sFo00001649@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the pleasure of a visit from the DMA fairy before. I found two
things that sometimes help.

1) reorganize the PCI cards to alter the interrupt sharing. This is
   a tiresome trial-and-error process that worked for me. When you
   find a working setup, close the case and use it [1].

2) Are you using APIC? try booting "noapic" and see how it goes

[1] The good old ham radio method of fixing a radio. Poke around with
a screwdriver, pushing the bits (these was in the days of valves and
such)
around until at some point, touching some object, the problem (whistle,
noise, cracking) stops. Solder the screwdriver to that object.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
