Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbREUPrc>; Mon, 21 May 2001 11:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261444AbREUPrW>; Mon, 21 May 2001 11:47:22 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:8463 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S261432AbREUPrG>; Mon, 21 May 2001 11:47:06 -0400
Date: Mon, 21 May 2001 17:47:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Adam Schrotenboer <schrotaj@river.it.gvsu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010521174721.A8020@suse.de>
In-Reply-To: <20010520005638.A18155@suse.de> <Pine.HPP.3.95.1010521114211.16648A-100000@river.it.gvsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.HPP.3.95.1010521114211.16648A-100000@river.it.gvsu.edu>; from schrotaj@river.it.gvsu.edu on Mon, May 21, 2001 at 11:44:01AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21 2001, Adam Schrotenboer wrote:
> On Sun, 20 May 2001, Jens Axboe wrote:
> 
> > On Sat, May 19 2001, Adam Schrotenboer wrote:
> > > /dev/raw*  Where? I can't find it in my .config (grep RAW .config). I am 
> > > using 2.4.4-ac11 and playing w/ 2.4.5-pre3.
> > 
> > It's automagically included, no config options necessary
> > (drivers/char/raw.c)
> 
> Then where is /dev/raw* ? I'm using devfs, if that helps any.

Apparently raw doesn't setup using the devfs_reg functions, someone need
to fix that. So either fix it (look at other drivers) or don't use
devfs.

-- 
Jens Axboe

