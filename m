Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264062AbRFYLdh>; Mon, 25 Jun 2001 07:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264272AbRFYLdS>; Mon, 25 Jun 2001 07:33:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48655 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264090AbRFYLdI>; Mon, 25 Jun 2001 07:33:08 -0400
Date: Mon, 25 Jun 2001 13:31:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Mike Galbraith <mikeg@wen-online.de>,
        Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
        John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Early flush (was: spindown)
Message-ID: <20010625133122.A21253@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de> <01062003503300.00439@starship> <200106200439.f5K4d4501462@vindaloo.ras.ucalgary.ca> <01062016294903.00439@starship> <200106201612.f5KGCca06372@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200106201612.f5KGCca06372@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Wed, Jun 20, 2001 at 10:12:38AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You know about this project no doubt:
> > 
> >    http://noflushd.sourceforge.net/
> 
> Only vaguely. It's huge. Over 2300 lines of C code and >560 lines in
> .h files! As you say, not really lightweight. There must be a better
> way. Also, I suspect (without having looked at the code) that it
> doesn't handle memory pressure well. Things may get nasty when we run
> low on free pages.

Noflushd *is* lightweight. It is complicated because it has to know
about different kernel versions etc. It is "easy stuff". If you add
kernel support, it will only *add* lines to noflushd.
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
