Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281843AbRLLUBl>; Wed, 12 Dec 2001 15:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281852AbRLLUBa>; Wed, 12 Dec 2001 15:01:30 -0500
Received: from dsl-213-023-039-104.arcor-ip.net ([213.23.39.104]:27909 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S281843AbRLLUBT>;
	Wed, 12 Dec 2001 15:01:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Date: Wed, 12 Dec 2001 21:03:20 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011211144223.E4801@athlon.random> <E16DooZ-0001J4-00@starship.berlin> <20011212121624.B4801@athlon.random>
In-Reply-To: <20011212121624.B4801@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16EFb9-0000E4-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 12, 2001 12:16 pm, Andrea Arcangeli wrote:
> On Tue, Dec 11, 2001 at 04:27:23PM +0100, Daniel Phillips wrote:
> > On December 11, 2001 03:23 pm, Andrea Arcangeli wrote:
> > > As said I wrote some documentation on the VM for my last speech at the
> > > one of the most important italian linux events, it explains the basic
> > > design. It should be published on their webside as soon as I find the
> > > time to send them the slides. I can post a link once it will be online.
> > 
> > Why not also post the whole thing as an email, right here?
> 
> I uploaded it here:

ftp://ftp.suse.com//pub/people/andrea/talks/english/2001/pluto-dec-pub-0.tar.gz

This is really, really useful.

Helpful hint: to run the slideshow, get magicpoint (debian users: apt-get 
install mgp) and do:

   mv pluto.mpg pluto.mgp # ;)
   mgp pluto.mgp -x vflib

Helpful hint #2: Actually, just gv pluto.ps is gets all the content.

Helpful hint #3: Actually, less pluto.mgp will do the trick (after the 
rename) and lets you cut and paste the text, as I'm about to do...

Nit: "vm shrinking is not serialized with any other subsystem, it is also 
                                                              only---^^^^
threaded against itself."

The big thing I see missing from this presentation is a discussion of how 
icache, dcache etc fit into the picture, i.e., shrink_caches.

--
Daniel

