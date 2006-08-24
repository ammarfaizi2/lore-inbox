Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965325AbWHXBaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965325AbWHXBaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 21:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965327AbWHXBaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 21:30:14 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:63231 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965325AbWHXBaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 21:30:13 -0400
Message-ID: <44ED0121.5080702@bigpond.net.au>
Date: Thu, 24 Aug 2006 11:30:09 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Rich Paredes <rparedes@gmail.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: SMP Affinity and nice
References: <38798.127.0.0.1.1156346673.squirrel@forexproject.com> <Pine.LNX.4.61.0608231735210.9588@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608231735210.9588@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Thu, 24 Aug 2006 01:30:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> Subject: SMP Affinity and nice
>>
>> I am trying to come to an understanding as to why 1 process is getting
>> less cpu time than identical processes with a higher "nice" value.
>> Server has 2 physical processors with hyperthreading (cpu 0,1,2,3)
>>
>> I am starting 5 processes that perform a square root loop to max out a
>> cpu.  They use the exact same code but are renamed for identification:
>> cpumax1, cpumax2, cpumax3, cpumax4, cpumax5
> [...]
> 
> What you describe should be addressed in the -ck patchset (smpnice-...diff) 
> Not sure if it is in mainline already, though.

It's coming in 2.6.18.

Rich,
	What kernel version are you using when you see this phenomenon?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
