Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbTBJLXi>; Mon, 10 Feb 2003 06:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbTBJLXh>; Mon, 10 Feb 2003 06:23:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:43741 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264818AbTBJLXe>;
	Mon, 10 Feb 2003 06:23:34 -0500
Date: Mon, 10 Feb 2003 03:33:27 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: reiser@namesys.com, piggin@cyberone.com.au, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
Message-Id: <20030210033327.5c24c052.akpm@digeo.com>
In-Reply-To: <20030210112104.GW31401@dualathlon.random>
References: <20030210045107.GD1109@unthought.net>
	<3E473172.3060407@cyberone.com.au>
	<20030210073614.GJ31401@dualathlon.random>
	<3E47579A.4000700@cyberone.com.au>
	<20030210080858.GM31401@dualathlon.random>
	<20030210001921.3a0a5247.akpm@digeo.com>
	<20030210085649.GO31401@dualathlon.random>
	<20030210010937.57607249.akpm@digeo.com>
	<3E4779DD.7080402@namesys.com>
	<20030210024810.43a57910.akpm@digeo.com>
	<20030210112104.GW31401@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 11:33:13.0186 (UTC) FILETIME=[3229C420:01C2D0F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> what is this fadvise doing?

Invoking fadvise64().  Dropping the pagecache.
 
> yes, and anticipatory scheduler isn't going to fix it. furthmore with
> IDE the max merging is 64k so you can see little of the whole picture.

124k.  (Or is it 128k now?)

