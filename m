Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313717AbSDUScd>; Sun, 21 Apr 2002 14:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313753AbSDUSbG>; Sun, 21 Apr 2002 14:31:06 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:4774 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313720AbSDUSaj>;
	Sun, 21 Apr 2002 14:30:39 -0400
Date: Sun, 21 Apr 2002 14:30:38 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: CaT <cat@zip.com.au>, Larry McVoy <lm@bitmover.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421143038.H8142@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <20020421175404.GL4640@zip.com.au> <20020421141200.D8142@havoc.gtf.org> <E16yzWX-0000lZ-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 08:23:49PM +0200, Daniel Phillips wrote:
> At the moment I'm thinking about returning to the patchbot project (by the
> way, code *is* available now) and reworking it to handle both BK and GNU
> patches.  The advantage of the patchbot is, it can do things like sniff
> patches for NOTIFYMEONCHANGE directives, auto-CC a linux-patches list,
> etc.  It could act as an accumulator of GNU patches into a BK repository,
> waiting for Linus to pull, and in the interim, all interested observers
> could also peek into the repository.

Go for it.  If you build it, they will come...
I'll reserve judgement until it is up and running, not just code available.
There has been lots of talk about patchbots, but I haven't seen anyone
crowing about their general-use patchbot on lkml.

I seriously doubt your system will work with GNU patches, though, as
they still go privately to Linus.  A big advantage of this patchbot
would be to expose GNU-style patches that would otherwise be "hidden" in
various BK repostories until Linus does a pull and a pre-patch.

(encouraging people to CC all patches to the patchbot would be a good
step, though, IMO)

	Jeff



