Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTHZQiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTHZQiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:38:08 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:12798 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261598AbTHZQiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:38:04 -0400
Message-ID: <3F4B8C8A.2060805@ccs.neu.edu>
Date: Tue, 26 Aug 2003 12:36:26 -0400
From: Stan Bubrouski <stan@ccs.neu.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030819
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: max@vortex.physik.uni-konstanz.de
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 shocking (HT) benchmarking (wrong logic./phys. HT
 CPU distinction?)
References: <200308261552.44541.max@vortex.physik.uni-konstanz.de>
In-Reply-To: <200308261552.44541.max@vortex.physik.uni-konstanz.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

max@vortex.physik.uni-konstanz.de wrote:
> Hello all you great Linux hackers,
> 
> in our fine physics group we recently bought a DUAL XEON P4 2666MHz, 2GB, with 
> hyper-threading support and I had the honour of making the thing work. In the 
> process I also did some benchmarking using two different kernels (stock 
> SuSE-8.2-Pro 2.4.20-64GB-SMP, and the latest and greatest vanilla 
> 2.6.0-test4). I benchmarked 
> 
> [1] kernel compiles (after 'cat'ting all files >/dev/null, into the buffer 
> cache) and 
> 
> [2] running time of a multi-threaded numerical simulation making extensive use 
> of FFTs, using the fftw.org library.
> 
> To cut the detailed story (below) short, the results puzzle me to a certain 
> extend: The physical/logical CPU distinction, which 2.6.0 is supposed to make 

I'm no kernel developer so take my opinion as worth more than
anyone else here (much less).  The new scheduler in the 2.6
kernels is still being tweaked by Con and Igno, et al.  But beyond
that there are several new ways to tweak the scheduler
designed to handled different loads, amounts of mem. etc...

Skimming the past few months of the mail list archives for
what to tweak and how may enhance the tasks you are currently
testing.  My $0.01 (I'm cheap like that).

-sb


