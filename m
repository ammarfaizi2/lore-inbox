Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313473AbSC3PfW>; Sat, 30 Mar 2002 10:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313491AbSC3PfM>; Sat, 30 Mar 2002 10:35:12 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:42972 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313473AbSC3PfE>;
	Sat, 30 Mar 2002 10:35:04 -0500
Message-ID: <3CA5DB27.1020705@candelatech.com>
Date: Sat, 30 Mar 2002 08:35:03 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PANIC with RH 2.4.9-31 kernel in UDP receive path.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was running ~50Mbps of UDP traffic, bi-directional on an over-night
run.  Machine is Celeron 500 in a FV24 motherboard.
Sometime in the night, this happened:

(Coppied by hand...hope I don't mess up)

EIP:     0010:[<c01ee5c0>]   Not tained
EFLAGS: 00010202
EIP is at udp_rcv [krenel] 0x30
.....
Call Trace [<c01d41b5>] ip_local_deliver [kernel] 0x129
ip_rcv 0x31f
tulip_interrupt 0x549
net_rx_action 0x190
handle_IRQ_event 0x35
do_softirq 0x47
do_IRQ 0x90
call_do_IRQ 0x5

I'll be going back to a newer kernel, but thought this might
interest some folks.
-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


