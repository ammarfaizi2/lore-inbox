Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSGMXeY>; Sat, 13 Jul 2002 19:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSGMXeX>; Sat, 13 Jul 2002 19:34:23 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:33206 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S315457AbSGMXeW>;
	Sat, 13 Jul 2002 19:34:22 -0400
Date: Sun, 14 Jul 2002 01:37:01 +0200
From: David Weinehall <tao@acc.umu.se>
To: c0330 <c0330@yingwa.edu.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Future of Kernel tree 2.0 ............
Message-ID: <20020713233701.GO29001@khan.acc.umu.se>
References: <E17TUXf-0000Ow-00@ited.yingwa.edu.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17TUXf-0000Ow-00@ited.yingwa.edu.hk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 09:35:03PM +0000, c0330 wrote:
> Hi everbody,
> 
> Will kernel tree 2.0 stop developing and regard historical after the
> release of 2.6?  I think we would put our focus on much more newer
> kernel. And I found this may confuse the newbies, because they don't
> know much about versioning in Kernel.
> 
> In nowsdays, there are less less compputers using 2.0. We should
> push them to upgrade, so I think stop developing 2.0 is better, in
> my opinion

The developer-force going into the 2.0-series is not very big. I
consolidate the few fixes I get sent my way that are reasonable, and
reject the rest (lately, most have been reasonable...), and try to
backport some fixes from 2.2/2.4 that are applicable. No new drivers are
added (or developed), and no new features are added.

Besides me, there are a few (no more than five) persons that regularly
report their success/failure/personal gripes with the latest
2.0-releases, and remind me to increase the release-number (I'm as bad
as Alan in this regard...)

The amount of work that I'd spend on a newer kernel would be about the
same, and since I've grown fond of this work, I'll probably not drop
2.0 unless I get offered to take over 2.2 or 2.4 some point in the
future.

Mind you, there _are_ people that still use 2.0 and wouldn't consider an
upgrade the next few years, simply because they know that their
software/hardware works with 2.0 and have documented all quirks.
Upgrading to a newer kernel-series means going through this work again.
And most likely, the upgrade would be to 2.2 rather than 2.4, because
2.4 still gets new features and API-changes now and then, something
generally frowned upon in a controlled environment.

I am about to release 2.0.40 soon, and while 40 is a nice round number,
42 is an even better number to stop at, so that'll probably be the end
of the road. That end lies quite some time in the future, though.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
