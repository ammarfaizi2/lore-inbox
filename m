Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311555AbSCTEdH>; Tue, 19 Mar 2002 23:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311554AbSCTEc6>; Tue, 19 Mar 2002 23:32:58 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31500 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311552AbSCTEcr>; Tue, 19 Mar 2002 23:32:47 -0500
Date: Tue, 19 Mar 2002 23:30:46 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: PlasmaJohn <lkml@projectplasma.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: I/O APIC fixed in 2.4.19-pre3 & 2.5.6 (was Re: Linux 2.4.19-pre3)
In-Reply-To: <Pine.LNX.4.21.0203192116020.15805-100000@bard.cbnet>
Message-ID: <Pine.LNX.3.96.1020319232518.4610B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, PlasmaJohn wrote:

> > Any chance this will cure the lockups on a Dell Latitude C600 every time
> > you exit X? I've disabled both the IO-APIC and APIC-uni, which was
> > supposed to fix the problem but didn't. Dare I hope that the disable
> > wasn't enough?
> 
> Does it also lock up when the text console blanks?

Never. Not when it's in X except when I logout.
 
> The X lockups were what had been plaguing me for the past two weeks.  
> I thought it was the new Radeon (7500), but it seems[1] to have been my 
> Asus CUSL2-C's[2] broken APM implementation (Quite recently Alan Cox 
> mentioned this problem with Asus' BIOS).
> 
> Out of fear, I do not compile in ACPI[3].

Never did after I saw the problem. And tried both noapic and disabling the
kernel option for IO-APIC and local APIC.
 
> I have since recompiled with APM as a module and life seems much more
> stable.  (I issue "modprobe apm" at shutdown so the box actually turns 
> off :)

Can't remember if it's a module, I kind of doubt it but it might be, I use
a LOT of modules.
 
> Perhaps your BIOS has similar "issues"?

Since I see this on lots of Dells I suspect a hardware issue. I may try a
FB version of X, but mainly I plan to get something else less broken
unless I can find a fix. Pity, the machine is really nice otherwise, other
than the WinModem it uses. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

