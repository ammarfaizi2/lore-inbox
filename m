Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317707AbSGKGpH>; Thu, 11 Jul 2002 02:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317710AbSGKGpH>; Thu, 11 Jul 2002 02:45:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20165 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317707AbSGKGpG>;
	Thu, 11 Jul 2002 02:45:06 -0400
Date: Thu, 11 Jul 2002 08:47:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Sebastian Droege <sebastian.droege@gmx.de>,
       linux-kernel@vger.kernel.org, akpm@zip.com.au, linux-mm@kvack.org
Subject: Re: [PATCH][RFT](2) minimal rmap for 2.5 - akpm tested
Message-ID: <20020711064712.GE1059@suse.de>
References: <Pine.LNX.4.44L.0207101741380.14432-100000@imladris.surriel.com> <E17SPS5-00028e-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17SPS5-00028e-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10 2002, Daniel Phillips wrote:
> On Wednesday 10 July 2002 22:42, Rik van Riel wrote:
> > On Wed, 10 Jul 2002, Sebastian Droege wrote:
> > > On Sat, 6 Jul 2002 02:31:38 -0300 (BRT)
> > > Rik van Riel <riel@conectiva.com.br> wrote:
> > >
> > > > If you have some time left this weekend and feel brave,
> > > > please test the patch which can be found at:
> > > >
> > > > 	http://surriel.com/patches/2.5/2.5.25-rmap-akpmtested
> > 
> > > after running your patch some time I have to say that the old VM
> > > implementation and the full rmap patch (by Craig Kulesa) was better. The
> > > system becomes very slow and has to swap in too much after some uptime
> > > (4 hours - 2 days) and memory intensive tasks...
> > > Maybe this happens only to me but it's fully reproducable
> > 
> > It's a known problem with use-once. Users of plain 2.4.18
> > are complaining about it, too.
> 
> Hey, thanks Rik, I know something about that :-)  And I'd be testing right
> now to see if you're right, if the DAC960 driver compiled successfully.
> But it doesn't, and since my test machine won't boot without it... given a
> choice between diving into the driver and going back to work on directory
> hashing on 2.4...

Leonard has promised me to convert DAC960 to the "new" pci dma api for
years (or so it seems, actual date may vary, no purchase necessary). I
do have a Mylex controller here myself these days, so it's not
completely impossible that I may do it on a rainy day.

-- 
Jens Axboe

