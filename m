Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWH3I4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWH3I4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWH3I4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:56:23 -0400
Received: from brick.kernel.dk ([62.242.22.158]:43020 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750716AbWH3I4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:56:22 -0400
Date: Wed, 30 Aug 2006 10:59:10 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       bzolnier@gmail.com
Subject: Re: [PATCH] HPA resume fix
Message-ID: <20060830085909.GC12257@kernel.dk>
References: <44F40F06.4010408@PicturesInMotion.net> <1156849911.6271.101.camel@localhost.localdomain> <20060829114210.GI12257@kernel.dk> <1156855828.6271.106.camel@localhost.localdomain> <20060829123223.GM12257@kernel.dk> <44F55275.2000400@PicturesInMotion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F55275.2000400@PicturesInMotion.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30 2006, Lee Trager wrote:
> Jens Axboe wrote:
> > On Tue, Aug 29 2006, Alan Cox wrote:
> >   
> >> Ar Maw, 2006-08-29 am 13:42 +0200, ysgrifennodd Jens Axboe:
> >>     
> >>> On Tue, Aug 29 2006, Alan Cox wrote:
> >>>       
> >>>> For -mm only to get more testing
> >>>>
> >>>> Acked-by: Alan Cox <alan@redhat.com>
> >>>>         
> >>> It should go into the state machine as described imho. Bart?
> >>>       
> >> If it works then yes it can become an explicit state. Firstly we need to
> >> find out if it works.
> >>     
> >
> > I think Lee tested and verified both this variant and the first one he
> > had, so I hope that it works :-)
> >
> >   
> It looks like we cross mailed. Anyway my patch is going into the mm
> sources for testing. For the record I've been using this for the past
> few weeks and its working great. I'll try to figure out how to create
> it's own resume step next and submit that.

Thanks, it should not be a lot of work!

-- 
Jens Axboe

