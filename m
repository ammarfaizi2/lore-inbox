Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267879AbUIJDbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267879AbUIJDbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUIJD3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:29:02 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:27322 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267879AbUIJD1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:27:38 -0400
Message-Id: <200409100322.i8A3MTCV004574@localhost.localdomain>
To: Hans Reiser <reiser@namesys.com>
cc: Paul Jakma <paul@clubi.ie>, "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes in reiser4 (brief attempt to document the idea ofwhat reiser4 wants to do with metafiles and why 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Thu, 09 Sep 2004 17:57:11 MST." <4140FBE7.6020704@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 09 Sep 2004 23:22:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> said:
> Paul Jakma wrote:
> > On Thu, 9 Sep 2004, Hans Reiser wrote:

[...]

> >> Putting \ into filenames makes windows compatibility less trivial.

> > Err, I think Ted used \ as an example of how to escape |. It is not 
> > part of the filename.

> It is not part of it at one level, but in the shell it is part of it.

What are you talking about?

> >> Putting | into filenames seems like asking for trouble with shells.

> > I think that was Ted's precise reason for arguing that | be used. Did 
> > you even read his rationale? :)

> That trouble is desirable?

He didn't say that at all. He said that '|' in filenames is currently
troublesome, so nobody will do it. Besides, '|' is dangerous in some
contexts, so it will probably already be filtered out where it might do
damage without any further work. This is important, you can't expect
everybody rewrite all their applications/web sites just because somebody
might be fooling around with Reiser4 to check it out.

>                            Yes, I can understand why he might not want 
> things to work well.;-)

It is very clear that you don't even try to understand criticism.

> >> If you think \| is user friendly, oh god, people like you are the 
> >> reason why Unix is hated by many.

It isn't. Ted's point is that the alternatives are much worse. Perhaps
using "meta" or something like that is friendlier at first sight, but if
your box is throroughly 0wn3d as a result, I'm sure your impression of
friendliness will radically change.

> > I think he was arguing | (not \|) is the least worst seperator to use.

Exactly.

> >> Rather few people understand closure though, so I don't expect to do 
> >> well in the politics of this.

Sorry for you, but either you convince the head kernel hackers (including
Ted, BTW) that you are right. And they are very hard to convince, only hope
is to present clear, clean solutions to the problems they raise. Nobody has
done so in this flamewar, AFAICS. Politics has very little to do with this.

> >>                               It is a bit like being for free trade, 
> >> most people will never understand why it is so important because 
> >> their mental gifts are in other matters,

Here you aren't talking to the counterpart of Joe Sixpack, you are trying
to convince the Economics Department of an ivy-league university that your
ideas on economics are right and they don't know what they are talking
about. Possible, but I'd call it somewhat unlikely.

> > Lots of people understand why free-trade is important. It's taught in 
> > introductory economics/business classes in secondary school.

> Have you looked at the political process at all? Or by lots of people, 
> do you mean a sizable minority?

Again, no political process in sight.

Please stop the handwawing, and address the core issues: Locking, POSIX
compatibility (or convince people that POSIX is wrong), costs of
implementing this (no, not just kernel implementation; also new
applications, application changes required, user/sysadmin retraining, etc).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
