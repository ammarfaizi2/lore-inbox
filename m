Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSDCOau>; Wed, 3 Apr 2002 09:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311756AbSDCOak>; Wed, 3 Apr 2002 09:30:40 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:57544 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311749AbSDCOad>; Wed, 3 Apr 2002 09:30:33 -0500
Date: Wed, 3 Apr 2002 16:17:31 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Chris Wilson <chris@jakdaw.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: P4/i845 Strange clock drifting
In-Reply-To: <20020403151012.5061d247.chris@jakdaw.org>
Message-ID: <Pine.LNX.4.44.0204031613160.2309-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Chris Wilson wrote:

> I've got a 1U 2.0 Ghz P4 rackmount server with an i845 chipset and have
> noticed some strange issues with the timer. For the most part it keeps
> time perfectly... but pretty often (tens of times each day) it'll have
> drifted anything from a few seconds to a few minutes - during a 10 minute
> period. It's always behind-time - so perhaps this is something to do with
> the P4's throttling stuff? Has anyone else seen similar?

The throttle is not supposed to affect the TSC, and only takes affect 
when overheating.

> I tried to use 2.5.7-dj2 with Zwane Mwaikambo's thermal LVT support in
> there but it didn't detect a local APIC on bootup (!) - I'm guessing there
> needs to be an APIC for Zwane's stuff? When I tried to switch back to

-dj2 P4 thermal patch is a bit broken (my bad), but the fact that it 
doesn't detect an APIC means that code would, erm do interesting things...

	Zwane

-- 
http://function.linuxpower.ca
		

