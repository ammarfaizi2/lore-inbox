Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWI3PnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWI3PnU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 11:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWI3PnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 11:43:20 -0400
Received: from ns.suse.de ([195.135.220.2]:14297 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751088AbWI3PnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 11:43:19 -0400
Date: Sat, 30 Sep 2006 17:32:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: tridge@samba.org
Cc: torvalds@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060930153241.GC6955@opteron.random>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com> <17692.41932.957298.877577@cse.unsw.edu.au> <1159512998.3880.50.camel@mulgrave.il.steeleye.com> <17692.53185.564741.502063@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17692.53185.564741.502063@samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Sep 29, 2006 at 05:48:17PM +1000, tridge@samba.org wrote:
> wishes.  I'm not even 100% certain it would be legal.

How can you not be sure that it would be legal? If you didn't want to
allow forking, you shouldn't have released the code as GPL. See qmail
and pine for example of slightly different licenses in terms of forking.

The basic logic of the GPL and open source as well, is that anyone is
legally allowed to fork away your code as much as they want as long as
the result is still using the same license. Oh well, if even this
_basic_ legal point is not clear, then I'm not surprised there's lots
of confusion about the rest...

IMHO GPL is _all_ about _freedom_ of usage in any shape and form, and
most important about _sharing_ of the resulting/modified code. GPL has
_never_ been about restricting usage. Infact it apparently even allows
you to do whatever you want with it as long as you do it behind the
corporate firewall and you don't redistribute the code itself, but
only the result of the computations of the code.

If there's something to work on for GPLv3 it is _not_ about
restricting usage. It's about forcing _more_ sharing even behind the
corporate firewall! In the ideal world that should be the only
priority in FSF minds and I think they're still in time to change
their focus on what really matters.

My ideal GPLv3 would be that if you modify a GPLv3 project and you
have a _third_party_ using in any way (think a web application running
behind the corporate firewall), you would be required to release your
GPLv3 source code to the third party that is using the GPLv3 code on
your servers, even if you never redistributed the code itself (nor in
source nor in binary form). Now I clearly don't know for sure if this
is enforceable, but I think this is the only point where the GPLv2
could be improved.

Nothing would change if the user of the code isn't a third party, so
for example you can still pick your preferred webmail for your
intranet, improve it, and release nothing back as long as it's never
used by third parties living outside the corporate firewall. But if
you start shipping the service to third parties as a webapplication
through the internet, my ideal GPLv3 would give the third parties the
right to see the modifications you did.

Creating a GPLv3 that restricts usage is not going to work. They think
the worst usage possible is DRM, I disagree, the DRM certainly
wouldn't be at the top of my priority of the worst possible usage of
my GPL code. Restricting usage is something where there cannot be a
real agreement on what should be forbidden, and as such it should be
avoided. If RMS has to choose which usage to forbid in GPLv3 he
apparently goes after DRM which sounds fair from his point of
view. Now if a greenpeace activist would have to choose he would
probably instead go after usage inside nuclear reactors which sounds
fair enough again from his point of view. I would go after different
things that sounds fair enough to me. If we keep focusing on
"forbidding what is unethical" eventually GPLv4 will forbid making too
much money off the software too ;). This is why there should be not be
any restriction on usage at all, so everyone can agree to giveup his
small wish for the common good. And if somebody really wants to add up
any exceptional restriction on usage on top of the GPL, that should be
up to the copyright holder to decide, not a job for the GPLv3 authors.

The worry that open source will eventually die with the advent of DRM
and trusted computing because no kernel will boot anymore, is
baseless. Who says something on those lines, probably doesn't
understand how the economy works (and most certainly they don't
understand how trusted computing works). To make an example if some
hardware vendor is not allowing to replace kernels, and I want to be
allowed to do that, I simply decided to buy my new htpc from
linuxtechtoys instead. It's truly as simple as that. And regardless,
even if they would be right about trusted computing going to kill open
source (again a baseless claim IMHO), it certainly wouldn't be the
GPLv3 DRM clause that could save us.

To make an example: I truly hope Microsoft will use trusted computing
to make the windows genuine update program totally unbreakable and to
force 100% of their users to pay. They can easily do that. There are
many more positive things around trusted computing that are never
being mentioned.

About the patent claims I also didn't see anything that would
invalidate the entire patent portfolio of any company (well, unless
the linux kernel already infringe on the whole patent portfolio of
said company, but I doubt that's what they meant ;). To me it looked
like v3 made explicit what was already implicit with v2 (i.e. when you
release patented software under GPLv2, you already implicitly allow
anybody to run your patented idea as long as the code is still under
the GPLv2). I didn't think there was any need to make it explicit, but
anyway I can't see a big difference.
