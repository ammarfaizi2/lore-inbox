Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291878AbSBYAEj>; Sun, 24 Feb 2002 19:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291889AbSBYAEa>; Sun, 24 Feb 2002 19:04:30 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:16768 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S291878AbSBYAET>;
	Sun, 24 Feb 2002 19:04:19 -0500
Message-ID: <3C797F82.4000602@candelatech.com>
Date: Sun, 24 Feb 2002 17:04:18 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: lockup on dual athlon system.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can repeatedly lockup my TYAN 2460 motherboard with
dual athlon MP 1600s by running make -j 4 modules
(ie build linux)

I'm running the 2.4.18-rc1 kernel with SMP + Athlon optimizations.

sysreq will not print anything out when it locks, and I've seen
it lock both in the console and with X running.  I'm not sure
how to go about debugging this any farther, but will be happy
to run tests or gather information if anyone can suggest something...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


