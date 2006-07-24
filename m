Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWGXMlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWGXMlj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 08:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWGXMlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 08:41:39 -0400
Received: from lucidpixels.com ([66.45.37.187]:5089 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932133AbWGXMli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 08:41:38 -0400
Date: Mon, 24 Jul 2006 08:41:37 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Matthias Andree <matthias.andree@gmx.de>
cc: Paa Paa <paapaa125@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: CFQ will be the new default IO scheduler - why?
In-Reply-To: <20060724082916.GB24299@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.64.0607240840560.1094@p34.internal.lan>
References: <BAY20-F21F536F116290D1C8F5FF4F9640@phx.gbl>
 <20060724082916.GB24299@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Jul 2006, Matthias Andree wrote:

> On Sun, 23 Jul 2006, Paa Paa wrote:
>
>> The default IO scheduler in 2.6.18 will be CFQ (Complete Fair Queuing)
>> instead of AS (Anticipatory Scheduler) as described here:
>> http://wiki.kernelnewbies.org/Linux_2_6_18. I tried to find (here, at lkml)
>> the discussion about this change with no luck.
>
> That wiki document nicely shows the advantage of the scheduler, namely
> that you have "ionice", which isn't possible for AS or Deadline
> Schedulers - this allows the operating system to run processes like
> updatedb with "nice I/O", meaning these hold when you're doing other
> I/O.
>
> -- 
> Matthias Andree
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Should there be a default scheduler per filesystem?  As some filesystems 
may perform better/worse with one over another?

Justin.
