Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbTCFAgt>; Wed, 5 Mar 2003 19:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTCFAgt>; Wed, 5 Mar 2003 19:36:49 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:54794 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S267123AbTCFAgs>; Wed, 5 Mar 2003 19:36:48 -0500
Subject: Re: Linux vs Windows temperature anomaly
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Russell King <rmk@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       Herman Oosthuysen <Herman@WirelessNetworksInc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E66964E.6050101@wmich.edu>
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz>
	 <p05210507ba8c20241329@[10.2.0.101]>
	 <3E66842F.9020000@WirelessNetworksInc.com>
	 <200303061038.44872.kernel@kolivas.org>
	 <20030305235057.M20511@flint.arm.linux.org.uk> <3E66964E.6050101@wmich.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1046911624.1051.35.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 05 Mar 2003 19:47:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The behavior you describe is when you increase the power output of a 
> chip beyond normal specifications (overclocking) then the temperature of 
> failure is lowered.  eg. A chip that would run normally at 50C now can 
> only run stable at 45-40.

You are the one mistaken.  Most CPUs don't dissipate a constant amount
of power as heat.  That depends on what the CPU is doing.  For example,
even the Athlon without disconnect will cool some when it is 'halt'ed. 
If a CPU is working more, accomplishing more than it was at another
time, it will be needing to rid itself of more heat.  Hence, the fact
that the external temperature becomes the limiting factor (along with
how good the heat exchange system is [i.e. heat sink/fan]).

I do believe the previous poster was incorrect about the mathematical
relationship between case and CPU temperatures.  They are NOT a 1:1. 
However, he is right, they are mathematically related.  Just as the heat
dissipated and the work done are related.

You do not need to overclock a CPU to get this kind of a change.  The
change in the efficiency (memory management, task switching, etc.) of
how the work is done can cause the CPU to be worked harder... and when
the CPU is worked harder, so is memory and quite often just about
everything else.

Trever
--
One O.S. to rule them all, One O.S. to find them. One O.S. to bring them
all and in the darkness bind them.

