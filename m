Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289412AbSAJMQn>; Thu, 10 Jan 2002 07:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289413AbSAJMQe>; Thu, 10 Jan 2002 07:16:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45064 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289412AbSAJMQT>;
	Thu, 10 Jan 2002 07:16:19 -0500
Date: Thu, 10 Jan 2002 13:15:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jim Crilly <noth@noth.is.eleet.ca>, Chris Ball <chris@void.printf.net>,
        Benjamin S Carrell <ben@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Bigggg Maxtor drives (fwd)
Message-ID: <20020110131557.Y19814@suse.de>
In-Reply-To: <3C3D191E.7090804@noth.is.eleet.ca> <Pine.LNX.4.33L.0201101010090.2985-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0201101010090.2985-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10 2002, Rik van Riel wrote:
> On Wed, 9 Jan 2002, Jim Crilly wrote:
> 
> > Actually it would seem this is just Andre's, not so subtle, way of
> > trying to prove that his ATA133/48-bit addressing patches need
> > included in 2.4.
> 
> I think you'll agree with him the moment you end up with
> a cheap 160 GB drive in your machine and the old driver
> (which is limited to 32(?)-bit LBA) won't let you use a
> large portion of the disk ;)

It's 28-bit LBA, which means

2^28 * 512 == 137GB (hard disk manufacturer gigs)

So waste is just 23GB :-)

Once the ide stuff has been proven, of course it will get integrated.

-- 
Jens Axboe

