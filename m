Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264162AbTEWUHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbTEWUHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:07:19 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:60683 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264162AbTEWUHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:07:18 -0400
Date: Fri, 23 May 2003 22:19:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Oliver Pitzeier <o.pitzeier@uptime.at>,
       "'Scott McDermott'" <vaxerdec@frontiernet.net>,
       "'Marc-Christian Petersen'" <m.c.p@wolk-project.de>,
       "'Sven Krohlas'" <darkshadow@web.de>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Message-ID: <20030523201959.GB16828@alpha.home.local>
References: <002b01c32107$b5686030$020b10ac@pitzeier.priv.at> <Pine.LNX.4.55L.0305231448440.32556@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305231448440.32556@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 02:52:44PM -0300, Marcelo Tosatti wrote:

> > Thanks for this information. Now it would be great to get a statement from
> > Marcelo, wouldn't it?
> > Why did you release the -rc3 without this? I believe there are more people like
> > me, that have such problems and do not even know about it.
> 
> Because it was too late for it to be included. It is a NEW driver and
> there is no WAY I will include it except early -pre's.

Marcelo,

although I respect your maintainer's responsible and safe position, I'd like
to state that version 6.2.28 has been in the latest pre-releases for quite some
time, and the reason you invoked for removing it at -rc time was the lockups
people still encounter with the version present in -rc3, perhaps to a lesser
extent. These lockups *SEEM* to have vanished from 6.2.33 for people who
complained previously. Moreover, the lockup I encountered on my systems was
fixed and demonstrated by Justin to really be a locking bug, so this was not
just a "let's see how it behaves" fix.

I think that if at least you had given it a try in -rc3 as a last chance, it
would have been a good opportunity for these people to hope for a stable kernel
on their production machines, and for Justin to have more bug reports if
problems still arose.

By this time, there will be more and more people leaving vanilla kernel for
their machines, and using them only as a base to apply -aa, -ac, -jam, -wolk,
-** + sf.net/* + who_knows_what, and I find it a shame.

I'm convinced that it's now a bit late and risky for a last minute change, but
I hope that 2.4.22 will be a really short release with only bug fixes, and all
the few important build fixes which were posted several times here. This way,
we'll be able to tell people "Don't jump on 2.4.21 yet, 2.4.22 is coming next
and will be a good one".

Just an opinion, not a flame. Have a nice week-end anyway.

Willy

