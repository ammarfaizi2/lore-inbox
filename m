Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161133AbVICEse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbVICEse (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 00:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbVICEse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 00:48:34 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:36781 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1161133AbVICEsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 00:48:33 -0400
Message-ID: <43192B1E.4020208@bigpond.net.au>
Date: Sat, 03 Sep 2005 14:48:30 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, kernel@kolivas.org, tytso@mit.edu,
       cfriesen@nortel.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost	tick	calculation
 in timer_pm.c
References: <20050831165843.GA4974@in.ibm.com>	 <20050831171211.GB4974@in.ibm.com> <1125720301.4991.41.camel@mindpipe>	 <43192423.2040400@bigpond.net.au> <1125722069.4991.43.camel@mindpipe>
In-Reply-To: <1125722069.4991.43.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 3 Sep 2005 04:48:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2005-09-03 at 14:18 +1000, Peter Williams wrote:
> 
>>In my experience, turning off DMA for IDE disks is a pretty good way to 
>>generate lost ticks :-)
> 
> 
> For this to "work" you have to unset "unmask IRQ" with hdparm, right?

I'm not familiar with that method.  When I've experienced this it's been 
due to me accidentally not configuring IDE DMA during configuration.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
