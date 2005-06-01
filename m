Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVFASEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVFASEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVFASA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:00:59 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:218 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S261509AbVFAR6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:58:53 -0400
Date: Wed, 1 Jun 2005 19:58:34 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pi_test predicted results
In-Reply-To: <Pine.LNX.4.44.0506011023480.5968-100000@dhcp153.mvista.com>
Message-Id: <Pine.OSF.4.05.10506011954340.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation is wrong... To my defence, I belived that was the result
when I wrote it because I assumed a slightly different behaviour, which
you can only obtain on UP.

Anyways, I think we found that the general bound is

 2^{depth} ms

(I have to find the old mails to check it though...)

It does require many threads though. But N=10 for d=3 giving 8 ms of
maximum latency should be enough. Notice, that the worst case should be
hit very rarely.

Esben


On Wed, 1 Jun 2005, Daniel Walker wrote:

> 
> 	What would you predict the results of the pi test with --tasks 10 
> and --depth 3 ?
> 
> 	From the docmentation it looks like depth N adds N milliseconds to 
> the locking latency . It seems like increasing the numbers of tasks would 
> also increase the locking latency by M tasks == M milliseconds. But I 
> thought I would ask to be sure..
> 
> Daniel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

