Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUIEMZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUIEMZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUIEMZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:25:42 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:32404 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266555AbUIEMZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:25:31 -0400
Message-ID: <1a56ea390409050525583d0438@mail.gmail.com>
Date: Sun, 5 Sep 2004 13:25:30 +0100
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler experiences
In-Reply-To: <1094386464.18114.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1094386464.18114.0.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004 14:14:24 +0200, Kasper Sandberg <lkml@metanurb.dk> wrote:
> Hey, i wonder which scheduler you people have the best experiences with,
> staircase or nicksched?
> 
> personally i were using nicksched for a long time, but then i tried
> staircase, and i like it overall more,
> 
> with nicksched its like, 1 process gets good prioity, so that if tvtime
> is running, it runs perfect, but moving windows and stuff will be not so
> fluid.
> with staircase, the overall performance is not as fast, but
> interactivity is really good, like tvtime runs fine, moving windows are
> fast as lightening, setiathome can also run perfect.
> 
> --
> Kasper Sandberg <lkml@metanurb.dk>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

I personally like staircase, i also used to use nicksched but i prefer
staircases simple design and structure. Nicksched was pretty fast but
twiddling around all day with renicing X and now the HT issues are
annoying and staircase has always worked perfectly for me without
flipping fifty switches in the cockpit.

-DaMouse

-- 
I know I broke SOMETHING but its there fault for not fixing it before me
