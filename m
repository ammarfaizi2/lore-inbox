Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130173AbRBZG2V>; Mon, 26 Feb 2001 01:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130174AbRBZG2M>; Mon, 26 Feb 2001 01:28:12 -0500
Received: from www.wen-online.de ([212.223.88.39]:61450 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130173AbRBZG2D>;
	Mon, 26 Feb 2001 01:28:03 -0500
Date: Mon, 26 Feb 2001 07:28:00 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marc Lehmann <pcg@goof.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux swap freeze STILL in 2.4.x
In-Reply-To: <20010225200021.A8653@cerebro.laendle>
Message-ID: <Pine.LNX.4.33.0102260717410.1294-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2001, Marc Lehmann wrote:

> On Sun, Feb 25, 2001 at 05:58:32PM +0100, Mike Galbraith <mikeg@wen-online.de> wrote:
> > > Usually I swapon ./swap some 512MB swapfile, but today I forgot it. When the
> > > machine started to get sluggish I sent the process a -STOP signal.
> >
> > Signal delivery during oomest does not work (last time I tested).
> > Andrea fixed this once.. long time ~problem.
>
> Well, the signal delivery seemed to have worked fine - the machine
> was quite usable (it swapped a lot, but the system was never unusable
> for longer than a second or so). The problem started when I did the
> swapon. Well, it didn't start, the system just froze.

Ok.. I guess that got fixed.  Used to be it was all over as soon
as the last of swap was consumed.

	-Mike

