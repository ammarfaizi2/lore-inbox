Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278722AbRKMNr2>; Tue, 13 Nov 2001 08:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279103AbRKMNrS>; Tue, 13 Nov 2001 08:47:18 -0500
Received: from ns.suse.de ([213.95.15.193]:9736 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278722AbRKMNrM>;
	Tue, 13 Nov 2001 08:47:12 -0500
Date: Tue, 13 Nov 2001 14:47:11 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <E163aNp-0000cm-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0111131439420.4157-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Alan Cox wrote:

> I wasnt aware mtrr.c had an active maintainer.

Well, hpa and myself are the only ones really maintaining it
in the last two years judging from the changelog. Some others
probably also contributed small changes not worthy of an entry.

> > "He who writes the code gets to choose".
> How about he who has to decipher the whole mess to add things...

It's grown to something of a monster imo. A complete rewrite for
2.5 would likely be the best thing to happen it in the last 5 years

I got the idea a while ago that splitting the various implementations
(Cyrix/K6/etc) out to seperate files would be a good start.
After I ripped it apart for an x86-64 version (not-yet-tested/merged),
I realised it still needs more work.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

