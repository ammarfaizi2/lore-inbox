Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314037AbSDQDTU>; Tue, 16 Apr 2002 23:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314039AbSDQDTT>; Tue, 16 Apr 2002 23:19:19 -0400
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:13462 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S314037AbSDQDTS>;
	Tue, 16 Apr 2002 23:19:18 -0400
Message-ID: <3CBCE9B3.2050508@candelatech.com>
Date: Tue, 16 Apr 2002 20:19:15 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: davidm@hpl.hp.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <15548.22093.57788.557129@napali.hpl.hp.com>	<Pine.LNX.4.44.0204161013050.1460-100000@blue1.dev.mcafeelabs.com> <15548.50859.169392.857907@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Mosberger wrote:


> The last time I measured timer tick overhead on ia64 it was well below
> 1% of overhead.  I don't really like using kernel builds as a
> benchmark, because there are far too many variables for the results to
> have any long-term or cross-platform value.  But since it's popular, I
> did measure it quickly on a relatively slow (old) Itanium box: with
> 100Hz, the kernel compile was about 0.6% faster than with 1024Hz
> (2.4.18 UP kernel).


How hard would it be to tune HZ dynamically at run time, either through
kernel smarts, or driven from user space by some sort of daemon or other
(manual) control?

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


