Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313115AbSDDJdp>; Thu, 4 Apr 2002 04:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313119AbSDDJdf>; Thu, 4 Apr 2002 04:33:35 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36699 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313115AbSDDJdZ>; Thu, 4 Apr 2002 04:33:25 -0500
Date: Thu, 4 Apr 2002 04:33:05 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.33.0204031106420.3004-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0204040413350.21480-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Apr 2002, Linus Torvalds wrote:

> Removing the .._GPL() is in this case correct, but not for any of the
> reasons mentioned, but simply because even Ingo agreed that it shouldn't
> be _GPL since it's explicitly meant for drivers that shouldn't have any
> knowledge whatsoever about the VM internals. GPL or not.

indeed. I had and still have no strong feelings either way, a patch to
remedy this was promised by me but not sent. I made it _GPL for pure
technical reasons: i saw no non-GPL drivers in 2.5 that used it, and at
first sight the functionality looked internal enough to warrant the _GPL
export. But in any case, while i might have written some of the patches,
the principal author of the final interface is Linus. Hopefully this is
the end of this story.

	Ingo

