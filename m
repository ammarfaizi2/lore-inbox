Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267515AbTBKKuB>; Tue, 11 Feb 2003 05:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbTBKKuB>; Tue, 11 Feb 2003 05:50:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9377 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267515AbTBKKuA>;
	Tue, 11 Feb 2003 05:50:00 -0500
Date: Tue, 11 Feb 2003 11:59:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <ckolivas@yahoo.com.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.60-cfq with contest
Message-ID: <20030211105944.GB930@suse.de>
References: <200302112155.17048.ckolivas@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302112155.17048.ckolivas@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11 2003, Con Kolivas wrote:
> Here's a quick set of the relevant results with the untuned CFQ by Jens:

Thanks!

> ctar_load:
> Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> 2.5.60              2   99      78.8    1.0     4.0     1.25
> 2.5.60-cfq          1   101     78.2    1.0     4.0     1.28
> xtar_load:
> Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> 2.5.60              2   101     76.2    1.0     5.0     1.28
> 2.5.60-cfq          1   115     66.1    1.0     4.3     1.46
> io_load:
> Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> 2.5.60              2   139     54.7    29.0    12.1    1.76
> 2.5.60-cfq          1   606     12.7    212.0   21.6    7.67
> io_other:
> Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> 2.5.60              2   90      83.3    10.8    5.5     1.14
> 2.5.60-cfq          1   89      84.3    10.8    5.6     1.13
> read_load:
> Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> 2.5.60              2   103     74.8    6.2     6.8     1.30
> 2.5.60-cfq          1   103     76.7    6.9     5.8     1.30
> list_load:
> Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> 2.5.60              2   95      80.0    0.0     6.3     1.20
> 2.5.60-cfq          1   95      81.1    0.0     6.3     1.20
> 
> Write based loads hurt. No breakages, but needs tuning. 

That's not even as bad as I had feared. I'll try to do some tuning with
contest locally.

-- 
Jens Axboe

