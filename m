Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317378AbSG2Gvj>; Mon, 29 Jul 2002 02:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSG2Gvj>; Mon, 29 Jul 2002 02:51:39 -0400
Received: from dhcp106-dsl-usw4.w-link.net ([208.161.125.106]:41618 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S317378AbSG2Gvi>;
	Mon, 29 Jul 2002 02:51:38 -0400
Message-ID: <3D44E6C1.6090002@candelatech.com>
Date: Sun, 28 Jul 2002 23:54:57 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: 8139too cannot receive pkts in 2.4.19-rc3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded a SpaceWalker SV-50 machine with a builtin Realtek
nic.  The NIC can no longer receive pkts it seems.  It can transmit
fine, as witnessed by other machines on the network.

lspci says the realtek is:
RTL-8139/8139C (rev 10)

The NIC is plugged into a 10bt hub.

The messages in /var/log/messages look like:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Setting half-duplex based on auto-negotiated partner ability 0000

I tested in on a 100bt-FD switch, and it failed there too, though it
did have a message in the log about negotiating 100bt-FD.

This works in stock RH 7.3 kernel.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


