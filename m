Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbSLFB1G>; Thu, 5 Dec 2002 20:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbSLFB1G>; Thu, 5 Dec 2002 20:27:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:23206 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267494AbSLFB1F>;
	Thu, 5 Dec 2002 20:27:05 -0500
Message-ID: <3DEFFEAA.6B386051@digeo.com>
Date: Thu, 05 Dec 2002 17:34:34 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 01:34:34.0224 (UTC) FILETIME=[A1879F00:01C29CC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> He may still suffer other known problems besides
> the above two critical highmem fixes (for example if
> lower_zone_reserve_ratio is not applied and there's no other fix around
> it IMHO, that's generic OS problem not only for linux, and that was my
> only sensible solution to fix it, the approch in mainline is way too
> weak to make a real difference)

argh.  I hate that one ;)  Giving away 100 megabytes of memory
hurts.

I've never been able to find the workload which makes this
necessary.  Can you please describe an "exploit" against 
2.4.20 which demonstrates the need for this?

Thanks.
