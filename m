Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284686AbRLEU3q>; Wed, 5 Dec 2001 15:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284672AbRLEU3h>; Wed, 5 Dec 2001 15:29:37 -0500
Received: from ns.ithnet.com ([217.64.64.10]:47620 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S284666AbRLEU3U>;
	Wed, 5 Dec 2001 15:29:20 -0500
Date: Wed, 5 Dec 2001 21:28:44 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: erich@uruk.org
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, lm@bitmover.com,
        jmerkey@timpanogas.org
Subject: Re: Loadable drivers  [was  SMP/cc Cluster description ]
Message-Id: <20011205212844.451f8781.skraw@ithnet.com>
In-Reply-To: <E16Bhtn-0004xf-00@trillium-hollow.org>
In-Reply-To: <E16BY3e-0005S9-00@the-village.bc.nu>
	<E16Bhtn-0004xf-00@trillium-hollow.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2001 11:40:07 -0800
erich@uruk.org wrote:

> This really goes into a side-topic, but plainly:
> 
> The general driver/random module framework in Linux really needs to get
> separated from the core kernel, and made so that it doesn't need to be
> recompiled between minor kernel versions.  Perhaps even pulling the
> drivers in general apart from each other, just aggregating releases for
> convenience.

You have just expressed my wildest nightmares. Just go ahead ...

> MS with Windows (and even DOS) went the right direction here.  In fact,
> they have been hurting themselves by what lack of driver interoperability
> there is even between Windows NT/2K/XP.  Admittedly they didn't have much
> of a choice with their closed-source scheme, but it still is a better
> solution from a usability and stability point of view in general.

You can only be plain kidding with this statement. If you split the drivers
from the rest of the kernel, you managed to get rid of this nice (yes, I really
meant nice) monolithic design, where I only need a simple config file to
_update_ to a new kernel revision (_up_, not _down_) and be happy (including
all the drivers). Obviously you just prove yourself wrong - mentioning not
working driver interoperability between NT/2K/XP whatever - with the idea that
it is indeed possible to make major new kernel versions (which should be
getting better btw) without _any_ changes in the driver framework that will
break your nice and stable but _old_ drivers. What's the use of this? You are
not talking about releasing driver-plugin-/framework-patches or the like just
to load _old_ drivers into _new_ kernel-environment?
Is this what they do at MS? Well if, they have not come that far.

> Don't get me wrong, I only run MS Software on 2 of my 8 machines (and
> have been trying to remove one of those with Wine/WineX), but I appreciate
> a better overall solution when I see one.

This brings up memories about reading Peter Nortons' latest hardcore books some
years ago, brrrr.

Reading between your lines, I can well see that you are most probably talking
about closed-source linux-drivers breaking with permanently released new kernel
revisions. But, in fact, this is the closed-source phenomenon, and _not_ linux.

> I will go so far as to say, for the long term this is necessary for the
> survival of Linux, and would help it's health even in the server arena.

You just invented the circle with edges: you are talking about "long-term" and
"MS drivers solution" at the same time. Remember, this company is currently
saying the product cycle is 3 years. I know pretty big companies that haven't
even managed to get the NT drivers really working under W2K, and were just shot
down by XP release.
I tend to believe we could just wait another two MS cycles to have even the
biggest MS-fans converted to kernel-hackers, only because of being real fed up
with the brilliant, long term driver design.
 
Regards,
Stephan
