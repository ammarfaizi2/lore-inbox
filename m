Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281877AbRLQSd2>; Mon, 17 Dec 2001 13:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281895AbRLQSdS>; Mon, 17 Dec 2001 13:33:18 -0500
Received: from www.jazzhouse.org ([216.254.75.62]:19460 "EHLO
	free.transpect.com") by vger.kernel.org with ESMTP
	id <S281877AbRLQSdH>; Mon, 17 Dec 2001 13:33:07 -0500
Date: Mon, 17 Dec 2001 13:29:59 -0500
From: Whit Blauvelt <whit@transpect.com>
To: safemode <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops - 2.4.17rc1
Message-ID: <20011217132959.A2096@free.transpect.com>
In-Reply-To: <20011215005641.A810@china.patternbook.com> <1008396931.17483.0.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1008396931.17483.0.camel@psuedomode>; from safemode@speakeasy.net on Sat, Dec 15, 2001 at 01:15:30AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2001 at 01:15:30AM -0500, safemode wrote:
> iptables comes with 2.4.x, why are you patching it against it?

Well, meant to type iptables 1.2.4 - well actually you need to run iptables'
install routine to properly make the utilities - it doesn't patch anything
that isn't already in the kernel, so if the kernel's up to 1.2.4, the oops
came from some other problem.

Subsequently I've gone to using some of the experimental patches against
2.4.16, which does require patching. No problem so far with that kernel.
That oops was against the scock 2.4.17rc1 version.

Whit
> 
> On Sat, 2001-12-15 at 00:56, Whit Blauvelt wrote:
> > Turns out it didn't leave a trace in the logs, but had a hard Oops less than
> > an hour into running this on a box that's been rock-solid stable for a
> > couple years, most recently running 2.2.19. 
> > 
> > Sorry I didn't hand copy the Oops screen - no time for that. Back to 2.2.19.
> > So this isn't so useful a report, except maybe to caution going beyond the
> > "rc" stage too soon on this one, just in case.
> > 
> > The iptables patch applied to it was just with the standard features,
> > nothing experimental.
> > 
> > Whit
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
