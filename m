Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSKJCT5>; Sat, 9 Nov 2002 21:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSKJCT5>; Sat, 9 Nov 2002 21:19:57 -0500
Received: from [195.223.140.107] ([195.223.140.107]:20869 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S262981AbSKJCT4>;
	Sat, 9 Nov 2002 21:19:56 -0500
Date: Sun, 10 Nov 2002 03:26:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Arador <diegocg@teleline.es>
Cc: Jens Axboe <axboe@suse.de>, conman@kolivas.net, akpm@digeo.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Message-ID: <20021110022608.GD2544@x30.random>
References: <200211091300.32127.conman@kolivas.net> <200211091612.08718.conman@kolivas.net> <20021109112135.GB31134@suse.de> <200211100009.55844.conman@kolivas.net> <20021109135446.GA2551@suse.de> <20021109221206.72d46e49.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021109221206.72d46e49.diegocg@teleline.es>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2002 at 10:12:06PM +0100, Arador wrote:
> On Sat, 9 Nov 2002 14:54:46 +0100
> Jens Axboe <axboe@suse.de> wrote:
> 
> > The default is 2048. How long does the io_load test take, or rather how
> 
> then, shouldn't the default be changed?. There's a big performance drop (/2)
> (in that case of course)

depends what side you are benchmarking, not always more throughput means
less interactivity, but at some point (when the more throughput can't
payoff for the reordering anymore) it does.

You should definitely benchmark 2.4.19-ck9 and 2.4.20rc1aa2 with dbench
too. Those numbers as is doesn't show the whole picture.

Andrea
