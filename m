Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281980AbRKUVIz>; Wed, 21 Nov 2001 16:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281979AbRKUVIp>; Wed, 21 Nov 2001 16:08:45 -0500
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:49164 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S281978AbRKUVIc>;
	Wed, 21 Nov 2001 16:08:32 -0500
Date: Wed, 21 Nov 2001 22:07:57 +0100 (CET)
From: Peter Svensson <petersv@psv.nu>
To: <berthiaume_wayne@emc.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Multicast Broadcast
In-Reply-To: <93F527C91A6ED411AFE10050040665D00241AB03@corpusmx1.us.dg.com>
Message-ID: <Pine.LNX.4.33.0111212206000.1086-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001 berthiaume_wayne@emc.com wrote:

> 	I have a cluster that I wish to be able to perform a multicast
> broadcast over two backbones, primary and secondary, simultaneously. The two
> eth's are bound to the same VIP. When I perform the broadcast, it only goes
> out on eth0. 

I think you need multicast routing for that to work the way you want it 
to. Flooding multicast traffic between network segments is normally the 
task for multicast routers since you need a routing protocol to prevent 
loops etc. If you send the data on both packets a multicast router 
connected to the two networks would forward a copy each way resulting in 
two packets on both segments.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


