Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129958AbRBYXNg>; Sun, 25 Feb 2001 18:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129941AbRBYXN0>; Sun, 25 Feb 2001 18:13:26 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:36868 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S129935AbRBYXNS>;
	Sun, 25 Feb 2001 18:13:18 -0500
Date: Sun, 25 Feb 2001 18:13:11 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Mike Galbraith <mikeg@wen-online.de>
cc: lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Patch failed
In-Reply-To: <Pine.LNX.4.33.0102250848340.2015-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.30.0102251811400.6345-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, I Discovered, something strange. I put in a blank new CD-R, so these
errors are not of concern? (In which case why have the kernel log get
spewed with them if they are guaranteed to happen?)

Shawn.

--
Hugged a Tux today? (tm)

On Sun, 25 Feb 2001, Mike Galbraith wrote:

> The way sg_low_malloc() tries to allocate, failure messages are
> pretty much garanteed.  It tries high order allocations (which
> are unreliable even when not stressed) and backs off until it
> succeeds.
>
> In other words, the messages are a red herring.
>
> 	-Mike
>
>
>


