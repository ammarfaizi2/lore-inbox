Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263285AbSJFDd0>; Sat, 5 Oct 2002 23:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263287AbSJFDd0>; Sat, 5 Oct 2002 23:33:26 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:158 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S263285AbSJFDdZ>;
	Sat, 5 Oct 2002 23:33:25 -0400
Message-ID: <3D9FB053.4040001@candelatech.com>
Date: Sat, 05 Oct 2002 20:38:59 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: Update on e1000 troubles (over-heating!)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I have figured out why the e1000 crashed my machine
after .5 - 1 hours:  The NIC was over-heating.  I measured one of
the NICs after the machine crashed with an external (cheap) temp
probe.  It registered right at 50 degrees C, and this was about 15-30
seconds after it crashed.

The dual e1000 NIC I have seems to run much cooler, and has been
running at 430Mbps bi-directional on both ports for about 6 hours now
with no obvious problems.

So, I'm going to try to purchase some heat sinks and glue them onto
the e1000 server nics, to see if that fixes the problem.

Hope this proves useful to anyone experiencing similar strange
crashes!

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


