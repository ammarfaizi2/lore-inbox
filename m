Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288833AbSANGnK>; Mon, 14 Jan 2002 01:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288835AbSANGnA>; Mon, 14 Jan 2002 01:43:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35337 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288833AbSANGmz>;
	Mon, 14 Jan 2002 01:42:55 -0500
Date: Mon, 14 Jan 2002 07:42:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIO Usage Error or Conflicting Designs
Message-ID: <20020114074245.B13929@suse.de>
In-Reply-To: <20020113135927.A11793@suse.de> <Pine.LNX.4.10.10201131157590.15103-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201131157590.15103-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13 2002, Andre Hedrick wrote:
> On Sun, 13 Jan 2002, Jens Axboe wrote:
> 
> > On Sat, Jan 12 2002, Andre Hedrick wrote:
> > > 
> > > Jens,
> > > 
> > > Here is back at you sir.
> > 
> > Without highmem debug enabled?? I already knew this was the bug
> > triggered, nothing new here.
> > 
> > Please print the two pfn values triggering the BUG_ON, I'll take a look
> > at this tomorrow.
> 
> That is with highmem debug on, the stuff at the end of the config file.
> Nothing more is generated, if there are more flags to set please tell me
> where.

Sorry if I wasn't clear, I mean the emulate highmem debug patch I
forwarded to you. I'll look into Manfred's post right now, you can
simply remove the

#ifndef CONFIG_HIGHMEM
	BUG();
#endif

test for now, for testing.

-- 
Jens Axboe

