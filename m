Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273440AbRIWVz6>; Sun, 23 Sep 2001 17:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273656AbRIWVzk>; Sun, 23 Sep 2001 17:55:40 -0400
Received: from pilot17.cl.msu.edu ([35.9.5.37]:59833 "EHLO pilot17.cl.msu.edu")
	by vger.kernel.org with ESMTP id <S273440AbRIWVzZ>;
	Sun, 23 Sep 2001 17:55:25 -0400
From: "Pei Zheng" <zhengpei@msu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: an IP stack problem regarding routing and ARP
Date: Sun, 23 Sep 2001 17:56:14 -0400
Message-ID: <LIECKFOKGFCHAPOBKPECEECGCLAA.zhengpei@msu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sorry to bother you all.
My question is about the Linux kernel IP stack regarding routing
tables and ARP.
Basically I am considering a hack on the IP stack for the  purpose of
routing emulation(emulating 2 routers in one kernel):

If a Linux box has 2 NICs, I would like to generate some packets in the
kernel, sent them out from one NIC to an Ethernet switch, and then
receive them on the other NIC. Is it possible, with the help of appropriate
routing table, routing rules and ARP configuration? Or the kernel IP
stack must be modified? It seems to me that if the kernel figures
out that a packet's next hop is its local network interface, it will
deliver to that interface through IP stack directly.

Thanks!

-Pei Zheng


