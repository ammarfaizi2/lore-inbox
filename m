Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286575AbRL0T5n>; Thu, 27 Dec 2001 14:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286582AbRL0T5d>; Thu, 27 Dec 2001 14:57:33 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:34246 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286575AbRL0T5Y>; Thu, 27 Dec 2001 14:57:24 -0500
Date: Thu, 27 Dec 2001 12:57:39 -0700
Message-Id: <200112271957.fBRJvdv00960@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <Pine.LNX.4.33L.0112271742470.12225-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33.0112271126550.1052-100000@penguin.transmeta.com>
	<Pine.LNX.4.33L.0112271742470.12225-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> On Thu, 27 Dec 2001, Linus Torvalds wrote:
> > On Thu, 27 Dec 2001, Rik van Riel wrote:
> > >
> > > Of course the patch will be updated when needed, but I still
> > > have a few 6-month old patches lying around that still work
> > > as expected and don't need any change.
> >
> > Sure. Automatic re-mailing can be part of the maintainership, if the
> > testing of the validity of the patch is also automated (ie add a
> > automated note that says that it has been verified).
> 
> Patch-bombing you with useless stuff has never been my
> objective. I just want to make sure valid patches get
> re-sent to you as long as there is a reason to believe
> they still need to be sent.
> 
> As soon as any hint arrives that the patch shouldn't be
> sent right now (a change was made to any of the files the
> patch applies to, I see something suspect in the changelog,
> the patch was applied, a reply was mailed to the patch...)
> the patch will be moved away for manual inspection.
> 
> I guess I'll also build in some kind of backoff to make sure
> the patch gets sent less often if you're not interested or too
> busy.

If you get this working nicely, it might even be a generally useful
thing. A set of perl scripts and easy interface commands could prove
popular. I would certainly find it convenient to have a patch
retransmission system that re-sent patches every time a new pre-patch
came out, and emailed me when the patch no longer applies. If it could
automatically de-queue when the patch is applied, or when I manually
remove it, that would be even better. And if I make an update to a
queued patch, it obsoletes the old one, that would be good too.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
