Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292841AbSCWLpQ>; Sat, 23 Mar 2002 06:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292852AbSCWLpG>; Sat, 23 Mar 2002 06:45:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41925 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292841AbSCWLox>;
	Sat, 23 Mar 2002 06:44:53 -0500
Date: Sat, 23 Mar 2002 12:40:56 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203231140.MAA14817@harpo.it.uu.se>
To: sp@scali.com
Subject: Re: Interrupts lost on Intel Plumas chipset
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002 09:06:10 +0100 (CET), Steffen Persvold wrote:
>> > > I have a SuperMicro P4DPR+ system here with Dual Intel Xeon 1.7GHz. This board utilizes the Intel
>> > > E7500 (Plumas) chipset. The chipset is configured with two P64H2 (PCI-X) Hubs, one which is
>> > > kernel-2.4.9-21smp (and I've also tried a stock 2.4.17 kernel), interrupts from the SCI card never
>...
>OK, I'm running 2.4.18 now and everything seems to be fine except that
>it's still CPU0 that handles all the interrupts. Is there a patch for this
>out there ? I'm willing to be a "crash test dummy" and even help out a
>bit.

Known P4 problem. Ingo Molnar posted a patch for it 10 days ago;
see the "Severe IRQ problems on Foster (P4 Xeon) system" thread.

/Mikael
