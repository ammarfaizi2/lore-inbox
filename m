Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135275AbRDZXBq>; Thu, 26 Apr 2001 19:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135257AbRDZXBh>; Thu, 26 Apr 2001 19:01:37 -0400
Received: from unthought.net ([212.97.129.24]:60297 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S135247AbRDZXB0>;
	Thu, 26 Apr 2001 19:01:26 -0400
Date: Fri, 27 Apr 2001 01:01:24 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Martin Clausen <martin@ostenfeld.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Semi-OT] Dual Athlon support in kernel
Message-ID: <20010427010124.B14524@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Martin Clausen <martin@ostenfeld.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0104240115050.21785-100000@asdf.capslock.lan> <20010425011842.A3942@ostenfeld.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010425011842.A3942@ostenfeld.dk>; from martin@ostenfeld.dk on Wed, Apr 25, 2001 at 01:18:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2001 at 01:18:42AM +0200, Martin Clausen wrote:
> On Tue, Apr 24, 2001 at 01:22:15AM -0400, Mike A. Harris wrote:
> > Also, what is a good rock solid SCSI RAID controller?  Money is
> > no object.  Reliability, performance and Linux compatibility are
> > though.
> 
> I have very good experiences with the Mylex controllers/drivers! 
> 
> But then again I also have good experiences with the new-style SW-RAID;
> it performs very well indead and it is quite cheap :) 

Remember, any RAID solution is based on software.  The difference is, whether
the software is closed-source and hiding on a slow processor, or free software
running on a much more powerful processor (which on the other hand also needs
to run other parts of the system, as this is the main CPU).

The main selling-points of software RAID except for stability and usually much
higher performance than "hardware" RAID is, that the interaction between the
userland tools and the RAID code is "open".   People who use RAID, be it one
kind or the other, occationally meet some problem where the RAID seems to be
having a will of it's own.  With the "open" solution, you as an administrator
actually have a chance of figuring out what happens.

I know the usual trouble-shooting on proprietary RAID seems to be "uh, it
doesn't work ?  well, try the newer drivers and firmware.  Oh, you did that,
well, then try the older versions then".   If people are comfortable with that
kind of systems, well, fine as long as it's not my data.   I want to know the
code I trust my data with.  From an theoretical point of view, it is stupid to
trust proprietary code - however, in the case of RAID I believe (at least some
of) the manufacturers has managed to prove that even from a purely pragmatic
point of view it is stupid to trust their code.

Yet, an awful lot of people seem to prefer the so-called "hardware" RAID  :)


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
