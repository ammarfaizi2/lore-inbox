Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTAaXEP>; Fri, 31 Jan 2003 18:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTAaXEP>; Fri, 31 Jan 2003 18:04:15 -0500
Received: from mail019.syd.optusnet.com.au ([210.49.20.160]:28614 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S263204AbTAaXEO> convert rfc822-to-8bit; Fri, 31 Jan 2003 18:04:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.59-mm7 with contest
Date: Sat, 1 Feb 2003 10:13:36 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200302010930.54538.conman@kolivas.net> <3E3B0030.5580060A@digeo.com>
In-Reply-To: <3E3B0030.5580060A@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302011013.36125.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 Feb 2003 10:01 am, Andrew Morton wrote:
> Con Kolivas wrote:
> > ...
> > io_load:
> > Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.59          3       153     50.3    8       13.7    1.94
> > 2.5.59-mm6      2       90      83.3    2       6.7     1.15
> > 2.5.59-mm7      5       110     68.2    2       6.4     1.41
> > read_load:
> > Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.59          3       102     76.5    5       4.9     1.29
> > 2.5.59-mm6      3       733     10.8    56      6.3     9.40
> > 2.5.59-mm7      4       90      84.4    1       1.3     1.15
>
> The background loads took some punishment.

Yes and I'd say a ratio of only 1.15 suggests kernel compilation got an unfair 
share of the resources.
