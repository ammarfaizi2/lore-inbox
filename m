Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbTAVTfG>; Wed, 22 Jan 2003 14:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTAVTfG>; Wed, 22 Jan 2003 14:35:06 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:64743 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262580AbTAVTfF>;
	Wed, 22 Jan 2003 14:35:05 -0500
Message-ID: <3E2EF490.20402@candelatech.com>
Date: Wed, 22 Jan 2003 11:44:16 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ksoftirqd_CPU0 spinning in 2.4.21-pre3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I happened to notice that my ksoftirqd_CPU0 process started spinning
at 99% CPU when I plugged in the ports to a tulip NIC.  I didn't see
any significant amount of interrupts when I looked at /proc/interrupts,
and there was no traffic running.

However, this is also running a hacked up tulip-napi driver, so it
could very well be my problem.  I have not seen this on any other kernel
in several months though...

Anyway, if anyone has seen this, I'd like to know.  Otherwise, I'll blame
my code and start poking at things...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


