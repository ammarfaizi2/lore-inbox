Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267978AbUJQWgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbUJQWgE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 18:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269311AbUJQWgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 18:36:04 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:11919 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267978AbUJQWgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 18:36:02 -0400
Message-ID: <4172F3C5.8090604@kolivas.org>
Date: Mon, 18 Oct 2004 08:35:49 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Clouter <alex-kernel@digriz.org.uk>
Cc: venkatesh.pallipadi@intel.com, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq_ondemand
References: <20041017222916.GA30841@inskipp.digriz.org.uk>
In-Reply-To: <20041017222916.GA30841@inskipp.digriz.org.uk>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Clouter wrote:
>> 3. (major) the scaling up and down of the cpufreq is now smoother.  I found 
> 	it really nasty that if it tripped < 20% idle time that the freq was 
> 	set to 100%.  This code smoothly increases the cpufreq as well as 
> 	doing a better job of decreasing it too

I'd much prefer it shot up to 100% or else every time the cpu usage went 
up there'd be an obvious lag till the machine ran at it's capable speed. 
  I very much doubt the small amount of time it spent at 100% speed with 
the default design would decrease the battery life significantly as well.

Cheers,
Con
