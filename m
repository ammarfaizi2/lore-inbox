Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131744AbQLRS1a>; Mon, 18 Dec 2000 13:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132289AbQLRS1T>; Mon, 18 Dec 2000 13:27:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21253 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131744AbQLRS1E>;
	Mon, 18 Dec 2000 13:27:04 -0500
Date: Mon, 18 Dec 2000 18:56:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Norbert Warmuth <nwarmuth@privat.circular.de>
Cc: Stanislav Brabec <utx@penguin.cz>, linux-kernel@vger.kernel.org
Subject: Re: ATAPI: audio CD still stops on >> (fast forward, 2.4.0-test12)
Message-ID: <20001218185613.A473@suse.de>
In-Reply-To: <20001216145940.C471@suse.de> <Pine.LNX.4.30.0012181835390.27844-100000@floh.privat.circular.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0012181835390.27844-100000@floh.privat.circular.de>; from nwarmuth@privat.circular.de on Mon, Dec 18, 2000 at 06:52:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18 2000, Norbert Warmuth wrote:
> On Sat, 16 Dec 2000, Jens Axboe wrote:
> > > But problem with >> (fast forward playng of short samples) still remains
> > > on some audio CD's.
> > > Dec 15 12:17:25 utx kernel:   "47 00 00 00 02 00 3c 3a ff 00 00 00 "
> > 							   ^^
> > This is the same case that Miles reported, it's very odd how that 8th
> > byte gets screwed somehow... But I know about this, I just haven't tracked
> > this down yet.
> 
> At least Stanislav's problem is a userland problem. Sometimes tcd/gtcd
> (the software Stanislav uses to play CDs) miscalculates frame values. A
> patch to tcd is available at http://bugs.gnome.org/db/33/33600.html.

Ah interesting, I _bet_ this is also what everybody else is seeing!

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
