Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267904AbTBVWeP>; Sat, 22 Feb 2003 17:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267907AbTBVWeP>; Sat, 22 Feb 2003 17:34:15 -0500
Received: from dhcp93-dsl-usw3.w-link.net ([206.129.84.93]:10693 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S267904AbTBVWeO>;
	Sat, 22 Feb 2003 17:34:14 -0500
Message-ID: <3E57FD42.7030606@candelatech.com>
Date: Sat, 22 Feb 2003 14:44:18 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
References: <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
>>OK, so now you've slid from talking about PCs to 2-way to 4-way ...
>>perhaps because your original arguement was fatally flawed.
> 
> 
> oh, come on.  the issue is whether memory is fast and flat.
> most "scalability" efforts are mainly trying to code around the fact
> that any ccNUMA (and most 4-ways) is going to be slow/bumpy.
> it is reasonable to worry that optimizations for imbalanced machines
> will hurt "normal" ones.  is it worth hurting uni by 5% to give
> a 50% speedup to IBM's 32-way?  I think not, simply because 
> low-end machines are more important to Linux.
> 
> the best way to kill Linux is to turn it into an OS best suited 
> for $6+-digit machines.

Linux has a key feature that most other OS's lack:  It can (easily, and by all)
be recompiled for a particular architecture.  So, there is no particular reason why
optimizing for a high-end system has to kill performance on uni-processor
machines.

For instance, don't locks simply get compiled away to nothing on
uni-processor machines?

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


