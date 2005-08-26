Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbVHZX1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbVHZX1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 19:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVHZX1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 19:27:04 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:926 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S965129AbVHZX1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 19:27:01 -0400
Message-ID: <430FA544.8000603@candelatech.com>
Date: Fri, 26 Aug 2005 16:27:00 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: danial_thom@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
References: <20050826210931.63327.qmail@web33309.mail.mud.yahoo.com>
In-Reply-To: <20050826210931.63327.qmail@web33309.mail.mud.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danial Thom wrote:

> I didn't refuse. I just chose to take help from
> Ben, because Ben took the time to reproduce the
> problem and to provide useful settings that made
> sense to me. There's nothing wrong with my
> machine. 

Well, I didn't see the slowdown on my system when I tried 2.6
v/s 2.4.  You reported a 3x slowdown.  In your original mail,
you didn't mention trying to do compiles at the same time
as your network test.  I *did* see a pathetic slowdown (from 250kpps
bridging to about 6kpps getting through the bridge) when I coppied
a 512MB CDROM to the HD, but let's get the pure network slowdown
on your system figured out before we start looking at the impact
of disk IO.

So, if you see a 3x slowdown on an unloaded machine when going
from 2.4 to 2.6, then there is something unique about your system
and we should figure out what it is.

Also, my numbers (about 250kpps with moderate amount of drops)
was a lot better than the 100kpps you reported for 2.6.  My
hardware is different (P-IV, HT, 3.0Ghz 1MB Cache, 1GB RAM,
dual Intel pro/1000 NIC in PCI-X 66/133 slot), but I would not
expect that to be 2x faster than your Opteron (or whatever you had).

You could mention what you are using to generate traffic.  (I was
using pktgen to generate a stream of 60 byte pkts.)

I think you should give us some better information on exactly
what you are doing on 2.4 v/s 2.6.  And for heaven's sake,
don't hesitate to send kernel configs and hardware listings
to folks that ask.  Ruling out problems is as useful as finding
problems in this sort of thing.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

