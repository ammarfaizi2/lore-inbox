Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266406AbTAPLbu>; Thu, 16 Jan 2003 06:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbTAPLbu>; Thu, 16 Jan 2003 06:31:50 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:59801 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266406AbTAPLbt>;
	Thu, 16 Jan 2003 06:31:49 -0500
Date: Thu, 16 Jan 2003 11:38:25 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any brand recomendation for a linux laptop ?
Message-ID: <20030116113825.GB21239@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Nicolas Turro <Nicolas.Turro@sophia.inria.fr>,
	linux-kernel@vger.kernel.org
References: <200301161100.45552.Nicolas.Turro@sophia.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301161100.45552.Nicolas.Turro@sophia.inria.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 11:00:45AM +0100, Nicolas Turro wrote:
 > 
 > Hi, 
 > I am software engineer at a french research institute, in charge of the linux 
 > support on about 600 computers. I am looking for laptops whith linux
 > support/certification. I couln't find any recent laptop model on your
 > certification page. Would you recomend me any brand of computer ?
 > We curently buy Compaq Evos laptops, but enabling linux on those laptops
 > is terrible :
 > - power management seems to be ACPI only (which linux barely supports)
 > - sound is hard or impossible to setup correctly.

I have an Evo 1015v, which is a bit of a pain to get working.
You need a very recent kernel just to be able to boot the thing, or
it'll lock up during hardware detection. Installer kernels typically
need to be booted with 'nomce', or probing causes a machine check.
The ATi Xserver locks up with a pretty display of garbage, (use
the vesa driver). Sound is currently not working afaik.
Power management: ACPI worked on it. Up until recently. Latest
2.5 seems to lock up very early in the boot.
Native Athlon Powernow support for cpufreq I'm working on, and am
making progress. IDE is a bit hit and miss. It works, but it's
no screamer in the performance dept. (Likely because no-one has
the relevant info from ATi on their south bridge).
AGP support is also lacking due to missing docs. DRI support
for that onboard Radeon mobility is afaik also missing.
Vesafb works.

So.. it's not that bad when you know the pitfalls, and it gets a good
3hrs or so on battery. (Which is pretty good for a 1300MHz CPU & large
display).

The key to why this one was such a pain was very likely the
"Designed for Windows XP" logo stuck to it.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
