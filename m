Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbQLRSYI>; Mon, 18 Dec 2000 13:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131744AbQLRSX7>; Mon, 18 Dec 2000 13:23:59 -0500
Received: from host242-166.circular.de ([212.86.166.242]:14599 "EHLO
	floh.privat.circular.de") by vger.kernel.org with ESMTP
	id <S130017AbQLRSXu>; Mon, 18 Dec 2000 13:23:50 -0500
Date: Mon, 18 Dec 2000 18:52:45 +0100 (CET)
From: Norbert Warmuth <nwarmuth@privat.circular.de>
To: Jens Axboe <axboe@suse.de>
cc: Stanislav Brabec <utx@penguin.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: ATAPI: audio CD still stops on >> (fast forward, 2.4.0-test12)
In-Reply-To: <20001216145940.C471@suse.de>
Message-ID: <Pine.LNX.4.30.0012181835390.27844-100000@floh.privat.circular.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2000, Jens Axboe wrote:
> > But problem with >> (fast forward playng of short samples) still remains
> > on some audio CD's.
> > Dec 15 12:17:25 utx kernel:   "47 00 00 00 02 00 3c 3a ff 00 00 00 "
> 							   ^^
> This is the same case that Miles reported, it's very odd how that 8th
> byte gets screwed somehow... But I know about this, I just haven't tracked
> this down yet.

At least Stanislav's problem is a userland problem. Sometimes tcd/gtcd
(the software Stanislav uses to play CDs) miscalculates frame values. A
patch to tcd is available at http://bugs.gnome.org/db/33/33600.html.

Regards,
Norbert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
