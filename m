Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313245AbSDDQbM>; Thu, 4 Apr 2002 11:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313248AbSDDQbD>; Thu, 4 Apr 2002 11:31:03 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33054 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S313245AbSDDQa5>; Thu, 4 Apr 2002 11:30:57 -0500
Date: Thu, 4 Apr 2002 11:29:39 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Rik van Riel <riel@conectiva.com.br>,
        Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <5.1.0.14.2.20020404164546.01f41b80@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0204041123410.6422-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Apr 2002, Anton Altaparmakov wrote:

> Both or these aren't really practical once you think it through. Don't
> forget that each binary module can be wrapped by an GPL-module which the
> kernel cannot do anything at all about and the kernel would never even
> know a binary only module was loaded because the GPL module does it.
> There is no such thing as security... This kind of thing is already in
> use by at least two companies I know of (i.e. using open sourced glue
> modules to binary only code) so it is not just a theory I am making
> up...

there are countries where this might be considered a 'circumvention of a
technological measure' that controls access to a work. Law enforcement is
not the duty of the copyright holders. There is no such thing as a
burglar-safe house either.

	Ingo

