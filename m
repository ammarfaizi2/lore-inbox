Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267318AbTAMIH0>; Mon, 13 Jan 2003 03:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTAMIHZ>; Mon, 13 Jan 2003 03:07:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23262 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267318AbTAMIHZ>;
	Mon, 13 Jan 2003 03:07:25 -0500
Date: Mon, 13 Jan 2003 09:15:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Rob Wilkens <robw@optonline.net>, Rik van Riel <riel@conectiva.com.br>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113081549.GL14017@suse.de>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030112211530.GP27709@mea-ext.zmailer.org> <1042406849.3162.121.camel@RobsPC.RobertWilkens.com> <Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com> <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12 2003, Rob Wilkens wrote:
> On Sun, 2003-01-12 at 16:40, Rik van Riel wrote:
> > OK, now imagine the dcache locking changing a little bit.
> > You need to update this piece of (duplicated) code in half
> > a dozen places in just this function and no doubt in dozens
> > of other places all over fs/*.c.
> > 
> > >From a maintenance point of view, a goto to a single block
> > of error handling code is easier to maintain.
> > 
> 
> There's no reason, though, that the error handling/cleanup code can't be
> in an entirely separate function, and if speed is needed, there's no
> reason it can't be an "inline" function.  Or am I oversimplifying things
> again?

*plonk*

-- 
Jens Axboe

