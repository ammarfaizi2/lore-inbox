Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSE0Lv2>; Mon, 27 May 2002 07:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSE0Lv1>; Mon, 27 May 2002 07:51:27 -0400
Received: from spruce.woods.net ([166.70.175.33]:12708 "EHLO a.smtp.woods.net")
	by vger.kernel.org with ESMTP id <S316588AbSE0Lv0>;
	Mon, 27 May 2002 07:51:26 -0400
Date: Mon, 27 May 2002 05:44:52 -0600 (MDT)
From: "Christopher E. Brown" <cbrown@woods.net>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1
In-Reply-To: <20020526160217.A1343@rushmore>
Message-ID: <Pine.LNX.4.44.0205270538140.584-100000@spruce.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 May 2002 rwhron@earthlink.net wrote:

> Another processor config could be CONFIG_K62.
> gcc-3.1 -march=k6-2 benchmarks a little better
> than -march=k6.  Adding CONFIG_XF86_USE_3DNOW=y
> seems to help a little too.
>
> Based on grepping gcc-3.1 src, it appears:
> k6-3 == k6-2


IIRC (not looking at the datasheets) there were some pretty nice
improvements made to the core in the K6 to K6-2 update (not just and
upclock and downsize, real changes(isn't this when they added MMX
too?)).


However, the K6-3 is simply a K6-2 with the addition of a 256K L2
cache on die at full cpu clock.  It was a great improvement
performance wise for many uses (think 256K L2 @ 450Mhz, and then a 2M
L3 on the mainboard) though.


-- 
I route, therefore you are.

