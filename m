Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270272AbRHHCfi>; Tue, 7 Aug 2001 22:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270273AbRHHCf2>; Tue, 7 Aug 2001 22:35:28 -0400
Received: from [202.81.130.34] ([202.81.130.34]:3083 "EHLO
	seawall.perth.wni.com") by vger.kernel.org with ESMTP
	id <S270272AbRHHCfX>; Tue, 7 Aug 2001 22:35:23 -0400
Message-Id: <5.1.0.14.0.20010808103510.00aafbb0@mailhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 08 Aug 2001 10:38:05 +0800
To: Ben Greear <greearb@candelatech.com>
From: Stuart Duncan <sety@perth.wni.com>
Subject: Re: ARP's frustrating behavior
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B70A0DA.DE33CB87@candelatech.com>
In-Reply-To: <5.1.0.14.0.20010808094513.00ab72c8@mailhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Evidently, this is considered a feature.  However, to turn it off:
>echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter

I've tried this and it doesn't work.  I understand that arp_filter uses 
routing tables to determine which interfaces should respond to ARP 
queries.  In my case, both interfaces are on the same network.

There isn't a lot of documentation available for the use of arp_filter.

Thanks,
Stuart Duncan


----
Stuart Duncan
Systems Administrator
WNI Weathernews
31 Bishop Street
JOLIMONT WA 6014


