Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbVHJUkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVHJUkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVHJUkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:40:23 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:17419 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030259AbVHJUkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:40:23 -0400
Message-ID: <42FA675A.5000408@tmr.com>
Date: Wed, 10 Aug 2005 16:45:14 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Peter Williams <pwil3058@bigpond.net.au>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE] Interbench 0.27
References: <200508031758.31246.kernel@kolivas.org>	<200508040925.57577.kernel@kolivas.org>	<200508040934.19498.kernel@kolivas.org> <200508041004.46675.kernel@kolivas.org>
In-Reply-To: <200508041004.46675.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Interbench is a benchmark application is designed to benchmark interactivity 
> in Linux.
> 
> Direct download link:
> http://ck.kolivas.org/apps/interbench/interbench-0.27.tar.bz2
> 
> Web page:
> http://interbench.kolivas.org
> 
> Changes:
> Standard deviation and average latency calculation was corrected. Gaming 
> standard deviation was implemented.

As you may or may not remember I have a response benchmark, which does 
different things... And one of the things I found is that when trying to 
determine if a tuning was "better" was to look at the 90 and/or 95 
percentile value. The max, average, and SD give you information which 
may be hard to really understand, but the "mostly better than X" times 
are pretty easy to understand.

I finally wound up using a dynamic percentile thing of my own creation, 
but there's no supporting theory, I just looked with response curve 
shapes and found a way to get numbers useful to me.

So you might find the percentile values pull additional information out 
of your data points, particularly for noisy results.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
