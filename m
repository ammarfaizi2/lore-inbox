Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286625AbRL0UiP>; Thu, 27 Dec 2001 15:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286635AbRL0UiG>; Thu, 27 Dec 2001 15:38:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36363 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286625AbRL0Uht>; Thu, 27 Dec 2001 15:37:49 -0500
Date: Thu, 27 Dec 2001 12:35:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rlimit_nproc
In-Reply-To: <Pine.LNX.4.33L.0112271816380.12225-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0112271224590.1167-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Dec 2001, Rik van Riel wrote:
>
> (not yet automated, scripts need to be written ... but the patch
> below would be a typical candidate ... are you happy with the way
> the description and patch are combined ?)

Looks fine, except for the fact that nowhere did it say which kernel
version the patch was generated against. Which is often a rather important
clue ;)

Now if you automate this, I would suggest adding a section in between the
explanation and the patch: the "diffstat" output of the patch. It doesn't
matter much for this example, because obviously the patch is small enough
that just scrolling down shows what's up, but..

I would also suggest that whatever activates the patch asks for a
subject-line that is more than 12 characters long ;)

Also worthwhile for automation is an md5sum or similar (for verifying that
the mail made it though the mail system unscathed). A pgp signature would
be even better, of course - especially useful as I suspect it would be
good to also cc the things to some patch-list, and having a clear identity
on the sender is always a good idea in these things.

			Linus

