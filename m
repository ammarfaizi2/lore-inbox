Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277382AbRKFFjT>; Tue, 6 Nov 2001 00:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277094AbRKFFi7>; Tue, 6 Nov 2001 00:38:59 -0500
Received: from 160-VALL-X5.libre.retevision.es ([62.83.215.160]:4870 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S277188AbRKFFiz>; Tue, 6 Nov 2001 00:38:55 -0500
Date: Tue, 6 Nov 2001 06:22:21 +0100
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: Stephen Satchell <satch@concentric.net>
Cc: Jonathan Lundell <jlundell@pobox.com>, dalecki@evision.ag,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011106062221.B182@ragnar-hojland.com>
In-Reply-To: <4.3.2.7.2.20011105080435.00bc7620@10.1.1.42> <200111042213.fA4MDoI229389@saturn.cs.uml.edu> <4.3.2.7.2.20011105080435.00bc7620@10.1.1.42> <p05100302b80c9aab7f40@[10.128.7.49]> <4.3.2.7.2.20011105133211.00bbfed0@10.1.1.42>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <4.3.2.7.2.20011105133211.00bbfed0@10.1.1.42>; from satch@concentric.net on Mon, Nov 05, 2001 at 01:43:11PM -0800
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 01:43:11PM -0800, Stephen Satchell wrote:
> At 11:58 AM 11/5/01 -0800, Jonathan Lundell wrote:
> >use of a version field. Rather than try to support all versions, use it to 
> >determine whether the two ends of the communication channel are 
> >compatible, and fail gracefully because of the incompatible version. Tell 
> >the user to update the app, or whatever.

[snip]

> And then there is the problem of who pays for my time to make the app 
> update.  I don't charge people for updates as a rule -- that rule may have 
> to change for my Linux apps if this ill-thought-out idea goes into the 
> kernel.  I expend enough effort trying to keep up with the crap coming out 

I hope you just don't mean the version number idea.  Because I don't see
reason for not, instead of adding a version number to every /proc file and
breaknig everything, adding all them to a /proc/proc-version file which 
would still let clients make some sanity checks.

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."
