Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313285AbSDDRsH>; Thu, 4 Apr 2002 12:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313280AbSDDRr6>; Thu, 4 Apr 2002 12:47:58 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28005 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313287AbSDDRrp>; Thu, 4 Apr 2002 12:47:45 -0500
Date: Thu, 4 Apr 2002 12:46:58 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <20020404185510.D32431@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0204041220501.23872-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Apr 2002, Andrea Arcangeli wrote:

> I don't really worry about that, important things will defend by
> themself, beacuse the GPL solution will be always superior of an order
> of magnitude. [...]

how do you do that if the GPL is not being honored? What if in 5 years
most of the distros ship heaps of binary-only drivers, filesystems,
storage solutions, and you'll need them just to be able to operate your
daily system. What if you cannot do certain changes to the kernel because
your system will not boot up without a certain binary-only module.

sure, today it's easy to say "i'm not using any 'stinkin binary-only
module". But tomorrow you might have no choice, because vendors will just
use binary-only modules to "support Linux". And while 'no module at all'
used to result in a GPL driver being developed quickly, are you sure
people will write a GPL replacement if there's a binary-only module
available? Even if there are such people, who will test the driver if the
binary-only driver is just 'good enough' for the majority of users? The
wide availability of binary-only modules was not an issue until now, so we
(well, a subset of the copyright holders) allowed it to a certain extent.
The reason why they werent an issue was simple: commercial entities saw
little value in Linux, so commercial kernel development was somewhere
between light and nonexistent.

These days Linux has already grown over a certain size, it's a big factor
in the server world, and it's a tiny but growing subset of the desktop
world as well - large enough to show up on the marketing radar of the
largest volume companies. So we are going to see much more development
that is not sympathetic (ie. neutral or even hostile) towards Linux as a
development community, so we have wear some protective gear against
'interesting' interpretations of the GPL and all related protection
measures we have. Believe me, those companies wouldnt mind if it costed
them $$$ to license the Linux source code, and if they had to sign NDAs to
see it, as long as they can be as secretive about the internal workings of
their technology as possible, and as long as they are able to say to users
that "we support Linux".

it's naive to think that our defenses (the GPL, API practices) that
guaranteed the 'fun' component of Linux development that you and i enjoyed
so much over the years can stay constant over time. New technologies
arise, laws change, even the interpretation of the constitution (of
certain countries) changes.

	Ingo

