Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287409AbSACRuY>; Thu, 3 Jan 2002 12:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSACRuP>; Thu, 3 Jan 2002 12:50:15 -0500
Received: from dialin-212-144-151-072.arcor-ip.net ([212.144.151.72]:15599
	"EHLO merv") by vger.kernel.org with ESMTP id <S288243AbSACRuC>;
	Thu, 3 Jan 2002 12:50:02 -0500
Date: Thu, 3 Jan 2002 18:50:37 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: Astinus <Astinus@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATHLON HELP ME ON THIS PLZ!!!!
Message-ID: <20020103175037.GC737@bombe.modem.informatik.tu-muenchen.de>
Mail-Followup-To: Astinus <Astinus@netcabo.pt>,
	linux-kernel@vger.kernel.org
In-Reply-To: <000901c192fc$66df2b00$d500a8c0@mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c192fc$66df2b00$d500a8c0@mshome.net>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 07:42:09PM -0000, Astinus wrote:
> Can anyone explian me why almost every body, even quite big servers bought
> athlon xps instead of the mp ones^??
> This is an issue that concerns me too!! You see,  ~why would a big server
> risk to buy a processor that may not work when the other one (mp) is suppose
> to work?? Is it for the extraa dollars u have to spend on the hardware???
> 
> Am I w~rong?? Are the MPs and the XPs so similar that the problems u have
> with one will be the same with the other???

They are in fact the same, except for the packaging (well, one says "XP"
the other says "MP") and possibly some ID number inside.

The difference is that MPs are tested by AMD for SMP capability and
guaranteed to work (ie. if they don't work you can have it replaced).
As I detailed in another mail, XPs can basically be of three types:

1) failed MP test, sold as XP
2) not tested for MP since market demands more XPs
3) passed MP test, but market demands more XPs

XPs are cheaper than MPs so people try those in SMP configs in the hope
that there are many type 3 XPs or that they get type 2 XPs that would
have passed the MP test.

It's impossible to tell which type you actually got, so the XPs in SMP
are always one of the main suspects if there is a problem.  In short,
you won't have those (CPU specific) problems with MPs.  If it's other
problems (chipset, for example) they could still appear.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
