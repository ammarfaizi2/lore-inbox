Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317643AbSFLG0x>; Wed, 12 Jun 2002 02:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317644AbSFLG0w>; Wed, 12 Jun 2002 02:26:52 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:20627 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317643AbSFLG0r>;
	Wed, 12 Jun 2002 02:26:47 -0400
Message-ID: <3D06E9A0.5060801@candelatech.com>
Date: Tue, 11 Jun 2002 23:26:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pekka Savola <pekkas@netcore.fi>
CC: Mark Mielke <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <Pine.LNX.4.44.0206120905510.29780-100000@netcore.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pekka Savola wrote:


> Just to chime in my support (not that I don't think anyone needs it), I 
> think socket-based counters are An Extremely Bad Idea.  


Several folks have produced arguments with details showing how they
can use the counters to better their product and/or debugging.  Just
waving your hands and saying you don't like it does not invalidate
their claims.  Please go back and read the thread and then, if you're
able, put forth some valid arguments for how to accomplish the goals
in some other manner, or show the negatives of including the feature.

If they are useful to some people, and have zero performance affect on others
(due to being a configurable kernel feature), then what is your
complaint?

I see two reasons left to dislike this feature:

1)  General increase in #ifdef'd code.  This actually seems like
    a pretty good argument, but I haven't seen anyone mention it
    specifically.

2)  General dislike for a feature that one personally has no use for.
    Seems to be Dave's main (professed) excuse.


Please add to this list, but back up your claims.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


