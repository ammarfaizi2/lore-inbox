Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288896AbSCCUMW>; Sun, 3 Mar 2002 15:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288914AbSCCUML>; Sun, 3 Mar 2002 15:12:11 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:32744 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S288896AbSCCUME>;
	Sun, 3 Mar 2002 15:12:04 -0500
Message-ID: <3C828393.7030501@candelatech.com>
Date: Sun, 03 Mar 2002 13:12:03 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: latency & real-time-ness.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been doing some tests with 2.4.19-pre2-ac2 with
regard to network latency.  When running a steady stream of
138byte UDP packets at 115 packets per second, I see about
.1% of the packets take more than 5 miliseconds to go from
user-space to user-space on a 1Ghz PIII machine.

At 50Mbps (bi directional), I see a much wider latency spread,
with some packets taking up to 300ms or higher to get from A
to B.  The CPU load ranges from about 30% to 80% utilization
at this speed...

I'm running the program at nice -18.

So, what kind of things can I do to decrease the latency?

Would the low-latency patch help me?

Are there any scheduling tricks I can use to tell the kernel
that my program should get to run as soon as it wants to?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


