Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSJJBYO>; Wed, 9 Oct 2002 21:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSJJBYN>; Wed, 9 Oct 2002 21:24:13 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:16855 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262190AbSJJBYN>;
	Wed, 9 Oct 2002 21:24:13 -0400
Message-ID: <3DA4D80E.8090707@candelatech.com>
Date: Wed, 09 Oct 2002 18:29:50 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 (netgear 302t) performance numbers
References: <3DA4D383.1010006@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:

> pktgen (kernel pkt generator module):
>   60-byte packets, sending 1kpps in one direction, and maximum possible
>   in the other.  Was able to generate 122,000 packets-per-second.
>   (A tulip 10/100 NIC can do 140kpps in this configuration)
>   Average Latency: 22 micro-seconds.
>   0 dropped packets over 10+ minute run.

An update to this.  This previous test, I was allocating a new skbuf
each time.  For pure pkt crunching (ie sending the same pkt over and over
again), the throughput was more like 170kpps.


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


