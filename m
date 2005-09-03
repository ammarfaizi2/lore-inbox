Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVICESr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVICESr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 00:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVICESr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 00:18:47 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:17249 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932310AbVICESq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 00:18:46 -0400
Message-ID: <43192423.2040400@bigpond.net.au>
Date: Sat, 03 Sep 2005 14:18:43 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, kernel@kolivas.org, tytso@mit.edu,
       cfriesen@nortel.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick	calculation
 in timer_pm.c
References: <20050831165843.GA4974@in.ibm.com>	 <20050831171211.GB4974@in.ibm.com> <1125720301.4991.41.camel@mindpipe>
In-Reply-To: <1125720301.4991.41.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 3 Sep 2005 04:18:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2005-08-31 at 22:42 +0530, Srivatsa Vaddagiri wrote:
> 
>>With this patch, time had kept up really well on one particular
>>machine (Intel 4way Pentium 3 box) overnight, while
>>on another newer machine (Intel 4way Xeon with HT) it didnt do so
>>well (time sped up after 3 or 4 hours). Hence I consider this
>>particular patch will need more review/work.
>>
> 
> 
> Are lost ticks really that common?  If so, any idea what's disabling
> interrupts for so long (or if it's a hardware issue)?  And if not, it
> seems like you'd need an artificial way to simulate lost ticks in order
> to test this stuff.

In my experience, turning off DMA for IDE disks is a pretty good way to 
generate lost ticks :-)

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
