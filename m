Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289370AbSA1UPg>; Mon, 28 Jan 2002 15:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289384AbSA1UPZ>; Mon, 28 Jan 2002 15:15:25 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:38277 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289369AbSA1UN6>;
	Mon, 28 Jan 2002 15:13:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jens Axboe <axboe@suse.de>, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [PATCH] sd-many for 2.4.18-pre7 (uses devfs)
Date: Mon, 28 Jan 2002 21:18:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200201280326.g0S3QTt27080@vindaloo.ras.ucalgary.ca> <200201281645.g0SGjZp02300@vindaloo.ras.ucalgary.ca> <20020128180142.A5588@suse.de>
In-Reply-To: <20020128180142.A5588@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VIEc-0000CJ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 06:01 pm, Jens Axboe wrote:
> On Mon, Jan 28 2002, Richard Gooch wrote:
> > Jens Axboe writes:
> > > Could you please at least try to follow the style in sd? To me, this
> > > alone is reason enough why the patch should not be applied.
> > 
> > ??? I *have* followed the style. Or at least I've tried to. Where did
> > I not?
> 
> you use
> 
> #ifdef something
> #  define something_else
> #endif

You're right, that's completely gross.  It should be:

  #ifdef something
    #define something_else
  #endif

;-)

Jens, in my opinion, your constant haranguing of Richard is getting stale, or 
got stale long ago.  I'd prefer not to see such posts on the list.  (I'd 
prefer not to see *this* post on the list either, but this needs to be said.)

-- 
Daniel
