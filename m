Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267120AbTBJLe1>; Mon, 10 Feb 2003 06:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbTBJLe1>; Mon, 10 Feb 2003 06:34:27 -0500
Received: from [195.223.140.107] ([195.223.140.107]:11138 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267120AbTBJLe0>;
	Mon, 10 Feb 2003 06:34:26 -0500
Date: Mon, 10 Feb 2003 12:43:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: reiser@namesys.com, piggin@cyberone.com.au, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210114347.GZ31401@dualathlon.random>
References: <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210024810.43a57910.akpm@digeo.com> <20030210112104.GW31401@dualathlon.random> <20030210033327.5c24c052.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210033327.5c24c052.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 03:33:27AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > what is this fadvise doing?
> 
> Invoking fadvise64().  Dropping the pagecache.
>  
> > yes, and anticipatory scheduler isn't going to fix it. furthmore with
> > IDE the max merging is 64k so you can see little of the whole picture.
> 
> 124k.  (Or is it 128k now?)

sure, sorry, the ide limit is 128k

Andrea
