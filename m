Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbUCYStu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 13:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUCYSr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 13:47:28 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:28115 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263523AbUCYSrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 13:47:10 -0500
Message-ID: <40632922.7080804@nortelnetworks.com>
Date: Thu, 25 Mar 2004 13:46:58 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marco Berizzi <pupilla@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: proxy arp behaviour
References: <DAV6695HfqR77bieLYC00007982@hotmail.com>
In-Reply-To: <DAV6695HfqR77bieLYC00007982@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Berizzi wrote:

> eth1 configuration is here:
> 
> ifconfig eth1 10.77.77.1 broadcast 10.77.77.3 netmask 255.255.255.252
> ip route del 10.77.77.0/30 dev eth1
> ip route add 172.17.1.0/24 dev eth1
> 
> echo 1 > /proc/sys/net/ipv4/conf/eth1/proxy_arp
> 
> Hosts connected to eth1 are all 172.17.1.0/24.
> The linux box is now replying to arp requests
> that are sent by 172.17.1.0/24 hosts on the eth1
> network segment.

Arp requests for what IP addresses?

Chris
