Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTCFOSD>; Thu, 6 Mar 2003 09:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTCFOSD>; Thu, 6 Mar 2003 09:18:03 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:3026 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S261463AbTCFOSC> convert rfc822-to-8bit; Thu, 6 Mar 2003 09:18:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Corvus Corax <corvusvcorax@gemia.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux vs Windows temperature anomaly
Date: Thu, 6 Mar 2003 08:27:49 -0600
User-Agent: KMail/1.4.1
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz> <200303061038.44872.kernel@kolivas.org> <20030306081804.4717d1c4.corvusvcorax@gemia.de>
In-Reply-To: <20030306081804.4717d1c4.corvusvcorax@gemia.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303060827.49620.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 March 2003 01:18 am, Corvus Corax wrote:
> Am Thu, 6 Mar 2003 10:38:44 +1100
>
> schrieb Con Kolivas <kernel@kolivas.org>:
> > That doesn't make sense. His post said the temperature was 20 degrees
> > lower when it failed.
> >
> > Con
>
> I think it does,

snip

> if the bridge has only a heatsink, its temperature is somewhat like
> (system TEMP)+ ( produced heatper time /  heat given to the air by heatsink
> per time ) where the heatsinks capacity is dependent on the delta
> temperature, too, gets complicated ;)
>
> in short, the chips hotter than the rest of the system and if it has high
> load it gets even hotter, but its temp is still dependant on the main
> system TEMP. ;)

It is also referred to as thermal inertia. It takes time for the heat sink to
1. heat up
2. start transferring that head out

During that time delay the chip may easily overheat in a burst of activity.

Same thing happens to fuses... a "slow blow" fuse will blow faster in higher
ambient temperature, under conditions that are normal because the AC was
turned on...

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
