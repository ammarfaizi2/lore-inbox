Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262850AbSJGDlV>; Sun, 6 Oct 2002 23:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262855AbSJGDlV>; Sun, 6 Oct 2002 23:41:21 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:8619 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262850AbSJGDlV>;
	Sun, 6 Oct 2002 23:41:21 -0400
Message-ID: <3DA103A2.1060901@candelatech.com>
Date: Sun, 06 Oct 2002 20:46:42 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Andre Hedrick <andre@pyxtechnologies.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: Re: Update on e1000 troubles (over-heating!)
References: <Pine.GSO.4.30.0210061835350.1861-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

> It seems like the prerequisite to reproduce it is you beat the NIC heavily
> with a lot of packets/sec and then run it at that sustained rate for at
> least 30 minutes. isci would tend to use MTU sized packets which will
> not be that effective.

I can reproduce my crash using mtu sized pkts running only 50Mbps send + receive
on 2 nics.  It took over-night to do it though.  Running as hard as I can with
MTU packets will crash it as well, and much quicker.

Interestingly enough, the tg3 NIC (netgear 302t), registered 57 deg C between
the fins of it's heat sink in the 32-bit slots.  Makes me wonder if my PCI bus
is running too hot :P

Dave says I'm wierd and no one else sees these bizarre problems, btw :)

More trouble-shooting to follow this next week.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


