Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272582AbRHaBeI>; Thu, 30 Aug 2001 21:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272583AbRHaBd6>; Thu, 30 Aug 2001 21:33:58 -0400
Received: from f22.law7.hotmail.com ([216.33.237.22]:8965 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S272582AbRHaBdw>;
	Thu, 30 Aug 2001 21:33:52 -0400
X-Originating-IP: [211.117.39.54]
From: "tobin park" <shinywind@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: IP Masquerade 
Date: Fri, 31 Aug 2001 01:34:05 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F22t6MWrnSxeFI8IioC000041e1@hotmail.com>
X-OriginalArrivalTime: 31 Aug 2001 01:34:05.0685 (UTC) FILETIME=[05AC6A50:01C131BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I want to insert the masquerade source in ip modules for studying network.
Let me know the simplest procedure(having no user interface)for masquerading 
the ip address into the outer interface(nic). (192.168.1.0/24 
->211.210.66.15/32)

---------------------------------------------------------------------------------
My procedure is
1. Hooked the ip_out procedure inserted my #ifdef sentence.
2. changed the socket buffer source address into the routing table source 
address.
3. updated the ip header checksum
4.. echo "1">/proc/sys/net/ipv4/ip_forward
----------------------------------------------------------------------------------

Let me know the correct procedure for masquerading.(Not depends on the 
existed mas
querading source)


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

