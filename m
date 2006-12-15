Return-Path: <linux-kernel-owner+w=401wt.eu-S1752712AbWLOPH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbWLOPH1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 10:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbWLOPH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 10:07:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50691 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752712AbWLOPH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 10:07:26 -0500
Date: Fri, 15 Dec 2006 16:07:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Scott Preece <sepreece@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/v2] CodingStyle updates
Message-ID: <20061215150717.GA2345@elf.ucw.cz>
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com> <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de> <20061215142206.GC2053@elf.ucw.cz> <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-12-15 08:52:22, Scott Preece wrote:
> On 12/15/06, Pavel Machek <pavel@ucw.cz> wrote:
> >Hi!
> >
> >> Pavel Machek wrote:
> >> >> From: Randy Dunlap <randy.dunlap@oracle.com>
> >> >> +Use one space around (on each side of) most binary and ternary 
> >operators,
> >> >> +such as any of these:
> >> >> +  =  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
> >> >
> >> > Actually, this should not be hard rule. We want to allow
> >> >
> >> >     j = 3*i + l<<2;
> >>
> >> Which would be very misleading. This expression evaluates to
> >>
> >>       j = (((3 * i) + l) << 2);
> >>
> >> Binary + precedes <<.
> >
> >Aha, okay. So this one should be written as
> >
> >        j = 3*i+l << 2;
> >
> >(Well, parenthesses should really be used. Anyway, sometimes grouping
> >around operator is useful, even if I made mistake demonstrating that.
> ---
> 
> I think the mistake illuminates why parentheses should be the rule. If
> you're thinking about using spacing to convey grouping, use
> parentheses instead...

Not in simple cases.

	3*i + 2*j should be writen like that. Not like
	(3 * i) + (2 * j)

								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
