Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTKPRaR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 12:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTKPRaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 12:30:17 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:49594 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263082AbTKPRaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 12:30:10 -0500
X-Sender-Authentication: net64
Date: Sun, 16 Nov 2003 18:30:07 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: mfedyk@matchmail.com, reiser@namesys.com, herbert@gondor.apana.org.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer
 error at fs/buffer.c:431"
Message-Id: <20031116183007.430f7a6a.skraw@ithnet.com>
In-Reply-To: <20031116170509.GB201@elf.ucw.cz>
References: <20031029141931.6c4ebdb5.akpm@osdl.org>
	<E1AGCUJ-00016g-00@gondolin.me.apana.org.au>
	<20031101233354.1f566c80.akpm@osdl.org>
	<20031102092723.GA4964@gondor.apana.org.au>
	<20031102014011.09001c81.akpm@osdl.org>
	<20031116130558.GB199@elf.ucw.cz>
	<20031116170509.GB201@elf.ucw.cz>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Nov 2003 18:05:09 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > If distribution had all packages unmodified, it would be useless...
> > 
> > Just contrary I'd state that this would be the "perfect world", because
> > this would mean all projects are in perfect shape and all patches have gone
> > to the respective maintainers.
> 
> Okay, in the perfect world we'd have just one distribution with all
> packages unmodified. Well.. but we are not there yet.

Well, why not head into the right direction at least? If we didn't try that
before we would probably have never left caves ...
 
> > So you say midnight commanders' maintainer is an a**hole, or what?
> > If you think some project needs patches, then please talk to its
> 
> Debian having diffs vs. vanilla midnight does not mean anything
> negative about its maintainer: Debian well may want different default
> config, for example (F3 viewer bindings came to mind).

Separate config diffs from original packages into new <project-config> package.
This way one can at least try to merge a new version of some rpm with a
standard distro config. diffs don't do that all to well.

> > > Of course it is good to keep the .diff as small as possible.
> > 
> > diffsize small is wanted.
> > diffsize zero is unwanted.
> > What kind of a logic is that?
> > 
> > Forgive me Pavel, that does not sound thoughtful to me.
> 
> If there's bug in the package, I expect Debian to fix the bug and then
> forward bugfix to the maintainer.

Sorry, if there is a bug in the package I expect the maintainer to fix it and
the distributor to help him (tell him about the problem, send patch
suggestions, whatever...).

> Distribution does not want to wait for maintainer to ACK, especially
> if its security-related bug.

This is probably one reason why quite a significant amount of
distro-patches/addons are quite questionable (at least). The distro-people
cannot accept that they see only their part of the whole picture and only
_think_ that they know perfectly well what joe-average-user wants, has and
needs. In fact they mostly have no idea. 
Debian could be a real win in this area if they only avoid others'
super-smartness.

Regards,
Stephan

