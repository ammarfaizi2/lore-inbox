Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292305AbSBBPjZ>; Sat, 2 Feb 2002 10:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292304AbSBBPjP>; Sat, 2 Feb 2002 10:39:15 -0500
Received: from mustard.heime.net ([194.234.65.222]:31148 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S292306AbSBBPjD>; Sat, 2 Feb 2002 10:39:03 -0500
Date: Sat, 2 Feb 2002 16:38:51 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Roger Larsson <roger.larsson@norran.net>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>, Tux mailing list <tux-list@redhat.com>
Subject: Re: Errors in the VM - detailed (or is it Tux? or rmap? or those
 together...)
In-Reply-To: <200202021535.g12FZ1417639@mailb.telia.com>
Message-ID: <Pine.LNX.4.30.0202021635530.10839-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have reread the first mail in this series - I would say that Bug#2 is much
> worse than Bug#1. This since Bug#1 is "only" a performance problem,
> but Bug#2 is about correctness...
>
> Are you 100% sure that tux works with rmap?

Of course not. How can I be sure???

> I would suggest testing the simplest possible case.
> * Standard kernel
> * concurrent dd:s

Won't work. Then all I get is (ref prob #1) good throughput until RAMx2
bytes is read from disk. Then it all falls down to ~1MB/s. See
http://karlsbakk.net/dev/kernel/vm-fsckup.txt for more details.

> What can your problem be:
> * something to do with the VM - but the problem is in several different VMs...
> * something to do with read ahead? you got some patch suggestions -
>   please use them on a standard kernel, not rmap (for now...)

Then fix the problem rmap11c fixed. I first need that fixed before being
able to do any further testing!

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

