Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRJTUDQ>; Sat, 20 Oct 2001 16:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274255AbRJTUDF>; Sat, 20 Oct 2001 16:03:05 -0400
Received: from zero.tech9.net ([209.61.188.187]:15635 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S274194AbRJTUC6>;
	Sat, 20 Oct 2001 16:02:58 -0400
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        "Linux-Kernel@Vger. " "Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20011020125629.A31863@mikef-linux.matchmail.com>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBKEOIDOAA.znmeb@aracnet.com>
	<20011020003812Z16243-4005+727@humbolt.nl.linux.org>
	<1003539951.939.3.camel@phantasy> 
	<20011020125629.A31863@mikef-linux.matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 20 Oct 2001 16:03:30 -0400
Message-Id: <1003608210.862.23.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-20 at 15:56, Mike Fedyk wrote:

> On Fri, Oct 19, 2001 at 09:05:29PM -0400, Robert Love wrote:
>
> > Agreed.  They also encourage people to write algorithms that are
> > suboptimal, but perform OK with proper tuning.  This, imho, is the
> > biggest argument against.
>
> How does this differ when the tuning is hard coded?
> 
> There are always cases where the algo will fall over.
> 
> One thing I can say in favor of hard coded tuning is that it encourages the
> cases where it does fall over to be reported, and possibly fixed.

Because if the tunings are hard coded, developers will be encouraged to
make sure those tunings serve at least some common case, if not most
cases.  If they are tunable, you get "the default tuning works for me. 
play with the proc settings to get it right...".

I don't agree with that.  Code it right.  If it takes a different tuning
for every case, then ditch the algorithm and let's find one that works
right.  Kind of like the point you just mentioned...

	Robert Love

