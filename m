Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313264AbSDDQ4W>; Thu, 4 Apr 2002 11:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313270AbSDDQ4N>; Thu, 4 Apr 2002 11:56:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:47156 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313267AbSDDQ4A>; Thu, 4 Apr 2002 11:56:00 -0500
Date: Thu, 4 Apr 2002 18:55:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Ingo Molnar <mingo@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020404185510.D32431@dualathlon.random>
In-Reply-To: <Pine.LNX.4.44.0204040747260.25330-100000@devserv.devel.redhat.com> <Pine.LNX.4.33.0204041625250.1089-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 04:35:33PM +0100, Tigran Aivazian wrote:
> kernel is protecting itself to make sure that "interesting" functionality

I share your same concerns, but I think "interesting" is way too much
vague to hold any legal meaning, furthmore even assuming "important"
means something (obviously not true) it's not priorly written anywhere
that "important" functionality had to be threated in a different manner.

> not necesserily "bad", i.e. it may well be necessary for Linux's survival

I don't really worry about that, important things will defend by
themself, beacuse the GPL solution will be always superior of an order
of magnitude. For istance I would never use the proprietary soltuion
despite it's temporarly better, because it would even prevent me to do
further developement. The important thing is that we never include non
GPL code in the mainline kernel and that the 99% of the code is under
the GPL licence and that it can be intermixed freely (basically only
modulo bsdcomp and a few other very exceptions in their own files with
bold letters about the BSD thing).

The only cases that can live as binary only long term are the ones
speaking with the hardware, when the hardware specs are not published
(and even that often is beaten by the GPL solution).

I think the current way of doing things is fine, I'd simply remove the
_GPL thing from kernel and modutils and then I'd return working on
technical things.

Andrea
