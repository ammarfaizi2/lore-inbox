Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264021AbSJTTKn>; Sun, 20 Oct 2002 15:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSJTTKm>; Sun, 20 Oct 2002 15:10:42 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:62482 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S264021AbSJTTKi>;
	Sun, 20 Oct 2002 15:10:38 -0400
To: Alan Cox <alan@redhat.com>
Cc: miura@da-cha.org (Hiroshi Miura), davej@suse.de, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: workaround for Cyrix MediaGX/NSC Geode companion CS5510/5520 PIT latch bug
References: <20021017170344.0C87C11782A@triton2>
	<200210201719.g9KHJeC21138@devserv.devel.redhat.com>
From: Christer Weinigel <christer@weinigel.se>
Date: 20 Oct 2002 21:16:41 +0200
In-Reply-To: <200210201719.g9KHJeC21138@devserv.devel.redhat.com>
Message-ID: <878z0shqee.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> > with this patch, timejumps or timebacks don't occurs.
> > This patch also removes dodgy_tsc() workaround.
> > 
> > this patch tried on mini note-PC CASSIOPEIA FIVA http://www.casio.co.jp/mpc/103/
> > you can get spec from http://www.da-cha.org/fiva/fiva.html
> 
> Excellent. My wife has a 5520 based system and I can test it there too. Dave
> if Windows always generates that delayed sequence (which btw the docs say
> the delay is required...) it may explain the similar VIA weirdness

I have seen a similar problem with a Geode SC1200 based system which
basically is a GX1 and a CS5530 integrated on one chip.  I'm starting
to wonder if the same bug has popped up again in the newer chip.

Unfortunately, I haven't got access to the troublesome system anymore
so I can't test the patch.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
