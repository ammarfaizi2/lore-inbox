Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267498AbSLLUtq>; Thu, 12 Dec 2002 15:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbSLLUtq>; Thu, 12 Dec 2002 15:49:46 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:14983 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267498AbSLLUto>;
	Thu, 12 Dec 2002 15:49:44 -0500
Date: Thu, 12 Dec 2002 21:56:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021212215656.A2078@ucw.cz>
References: <1039610907.25187.190.camel@pc-16.office.scali.no> <3DF78911.5090107@zytor.com> <1039686176.25186.195.camel@pc-16.office.scali.no> <20021212203646.GA14228@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021212203646.GA14228@mark.mielke.cc>; from mark@mark.mielke.cc on Thu, Dec 12, 2002 at 03:36:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 03:36:46PM -0500, Mark Mielke wrote:
> On Thu, Dec 12, 2002 at 10:42:56AM +0100, Terje Eggestad wrote:
> > On ons, 2002-12-11 at 19:50, H. Peter Anvin wrote:
> > > Terje Eggestad wrote:
> > > > PS:  rdtsc on P4 is also painfully slow!!!
> > > Now that's just braindead...
> > It takes about 11 cycles on athlon, 34 on PII, and a whooping 84 on P4.
> > For a simple op like that, even 11 is a lot... Really makes you wonder.
> 
> Some of this discussion is a little bit unfair. My understanding of what
> Intel has done with the P4, is create an architecture that allows for
> higher clock rates. Sure the P4 might take 84, vs PII 34, but how many
> PII 2.4 Ghz machines have you ever seen on the market?
> 
> Certainly, some of their decisions seem to be a little odd on the surface.
> 
> That doesn't mean the situation is black and white.

Assume a 1GHz P-III. 34 clocks @ 1GHz = 34 ns. 84 clocks @ 2.4 GHz = 35 ns.
That's actually slower. Fortunately the P4 isn't this bad on all
instructions.

-- 
Vojtech Pavlik
SuSE Labs
