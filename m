Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313759AbSDUTB7>; Sun, 21 Apr 2002 15:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313764AbSDUTB6>; Sun, 21 Apr 2002 15:01:58 -0400
Received: from dsl-213-023-040-105.arcor-ip.net ([213.23.40.105]:9365 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313759AbSDUTB6>;
	Sun, 21 Apr 2002 15:01:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <garzik@havoc.gtf.org>, Rasmus Andersen <rasmus@jaquet.dk>
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Sat, 20 Apr 2002 21:01:26 +0200
X-Mailer: KMail [version 1.3.2]
Cc: CaT <cat@zip.com.au>, Larry McVoy <lm@bitmover.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yzWX-0000lZ-00@starship> <20020421143038.H8142@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16z06w-0000mM-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 April 2002 20:30, Jeff Garzik wrote:
> On Sat, Apr 20, 2002 at 08:23:49PM +0200, Daniel Phillips wrote:
> > At the moment I'm thinking about returning to the patchbot project (by the
> > way, code *is* available now) and reworking it to handle both BK and GNU
> > patches.  The advantage of the patchbot is, it can do things like sniff
> > patches for NOTIFYMEONCHANGE directives, auto-CC a linux-patches list,
> > etc.  It could act as an accumulator of GNU patches into a BK repository,
> > waiting for Linus to pull, and in the interim, all interested observers
> > could also peek into the repository.
> 
> Go for it.  If you build it, they will come...
> I'll reserve judgement until it is up and running, not just code available.
> There has been lots of talk about patchbots, but I haven't seen anyone
> crowing about their general-use patchbot on lkml.
> 
> I seriously doubt your system will work with GNU patches, though, as
> they still go privately to Linus.  A big advantage of this patchbot
> would be to expose GNU-style patches that would otherwise be "hidden" in
> various BK repostories until Linus does a pull and a pre-patch.
> 
> (encouraging people to CC all patches to the patchbot would be a good
> step, though, IMO)

In fact, the basic premise is that people mail to the patchbot, not the
maintainer.  The patchbot knows who the maintainer is and forwards the patch
to the maintainer, using the maintainer's format of choice, or as now
proposed, just drops it into the BK repository and forwards a notification,
both to the maintainer and the linux-patches list.

-- 
Daniel
