Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292453AbSBPRXj>; Sat, 16 Feb 2002 12:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292456AbSBPRXa>; Sat, 16 Feb 2002 12:23:30 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:54536
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292453AbSBPRXQ>; Sat, 16 Feb 2002 12:23:16 -0500
Date: Sat, 16 Feb 2002 11:57:39 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible breakthrough in the CML2 logjam?
Message-ID: <20020216115739.B32311@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215213833.J27880@suse.de> <1013810923.807.1055.camel@phantasy> <20020215232832.N27880@suse.de> <3C6DE87C.FA96D1D6@mandrakesoft.com> <20020216095202.M23546@thyrsus.com> <3C6E7C75.A6659D72@mandrakesoft.com> <20020216105219.A31001@thyrsus.com> <3C6E8A15.D5C209B1@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6E8A15.D5C209B1@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Feb 16, 2002 at 11:34:29AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> Global dependencies...  CML1 doesn't have this now, and it needs never
> to have it.  This is no point in merging a design change of that
> magnitude only to take it away later on.  Further, merging a rulebase
> which contains such dependencies would be a huge mistake that might take
> years to undo.  drivers/net/rules.cml doesn't need S/390 stuff in it,
> AFAICT, and that is a simple example of a bug found in many of the
> rules.cml files.

All right.  There are a couple of ways we can attack this -- I have
some ideas.  But I want a meta-question answered first.  If we solve
this issue, *are you on board*?

I've got to get off the fscking treadmill I'm on now where I'm spending
so much time on the parallel-rulebase maintainance and the flaming
politics that I can't really get anything else done.  

After what you wrote upthread, I don't think you want me to be stuck
either.  Fact: ain't nobody else visible with both the motivation and
skills to tackle what you want done.  I've been thinking about
metadata-centered configuration and consciously bending CML2's design
towards it for longer than anyone else has even been considering the
problem.

I *will* get us there -- I think the last two years have demonstrated
my determination.  But to do it, I need alliance rather than
obstruction. I need you to tell Linus that your concerns have been met
and sponsor CML2 to go in, so I can stop perpetually re-fighting old
battles.

Because we agree on getting to metadata-centered configuration, your
requirements list now appears to have shrunk to one.  You want to
"eliminate global depencies".  I hear that.  I got it.  

What I want to know is that this is not a proxy for "CML2 can never be
good enough" and that you'll be pulling more objections out of your butt
till the Sun goes nova.  Because if that's true there's no point in
my trying to work with you. 

But if "eliminate global depencies" is it, we can be allies, because 
ultimately we both want to get the config system to the same place. 
I've taken the first, biggest step -- from imperative code to 
declaration/constraint language.  The second -- from a
declaration/constraint language to a metadata-centered system -- 
will be easier.

A positive answer may be "Yes, that's it, let's go forward", or
"Almost, there are a couple other minor and negotiable issues *which I
will now list*" (where "Minor and negotiable" = "I don't have to scrap
my architecture").
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
