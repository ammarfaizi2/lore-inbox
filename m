Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318365AbSG3Rfq>; Tue, 30 Jul 2002 13:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318366AbSG3Rfq>; Tue, 30 Jul 2002 13:35:46 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33805 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318365AbSG3Rfp>; Tue, 30 Jul 2002 13:35:45 -0400
Date: Tue, 30 Jul 2002 13:33:23 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block/elevator updates + deadline i/o scheduler
In-Reply-To: <20020726120248.GI14839@suse.de>
Message-ID: <Pine.LNX.3.96.1020730132645.4849B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002, Jens Axboe wrote:
> Finally, I've done some testing on it. No testing on whether this really
> works well in real life (that's what I want testers to do), and no
> testing on benchmark performance changes etc. What I have done is
> beat-up testing, making sure it works without corrupting your data. I'm
> fairly confident that does. Most testing was on SCSI (naturally),
> however IDE has also been tested briefly.

First, great job on the explanation, it went right in my folder for "when
the docs are clear" explanations.

Now a request, if someone is running a database app and tests this I'd
love to see the results. I expect things like LMbench to show more threads
ending at the same time, but will it help a reall app?

I bet it was tested briefly on IDE, my last use of IDE a week or so ago
lasted until I did "make dep" and the output went all over every attached
drive :-( Still, nice to know it will work if IDE makes it into 2.5.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

