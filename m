Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932775AbWF1L2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbWF1L2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbWF1L2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:28:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:52436 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932775AbWF1L2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:28:40 -0400
Message-ID: <b29067a0606280428tff7b9dcp66bac3f2b83f4cc6@mail.gmail.com>
Date: Wed, 28 Jun 2006 07:28:38 -0400
From: "Rahul Karnik" <rahul@genebrew.com>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/9] Extents support.
Cc: "Jens Axboe" <axboe@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200606271739.13453.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
	 <200606271539.29540.nigel@suspend2.net>
	 <20060627070505.GH22071@suse.de>
	 <200606271739.13453.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> Suspend2 is a
> reimplementation of swsusp, not a series of incremental modifications. It
> uses completely different methods for writing the image, storing the metadata
> and so on. Until recently, the only thing it shared with swsusp was the
> refrigerator and driver model calls, and even now the sharing of lowlevel
> code is only a tiny fraction of all that is done.

This is something I don't understand. Why can you not submit patches
that simply do things like "change method for writing image" and
reduce the difference between suspend2 and mainline? It may be more
work, but I think you will find that incremental changes are a lot
easier for people to review and merge.

Right now, it seems like Linus and Andrew have only two choices:

1. Ignore your submission
2. Merge all of suspend2

We have had complete reworks of entire subsystems in the 2.6 series
without problems, simply because the effort was taken to make the
changes incrementally.

> Could I ask what might be a dumb question in this regard - why isn't Reiser4
> going through the same process?

reiser4 has been in -mm for quite a while without being merged into
mainline. I don't think you want the same fate for suspend2.

Finally, I just want to say I appreciate all the effort you (and Pavel
and Rafael) are putting into suspend-to-disk. It is critical
functionality for me and I think we can get both a well functioning
and maintainable implementation.

Thanks,
Rahul
-- 
Rahul Karnik
rahul@genebrew.com
