Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSJQMdU>; Thu, 17 Oct 2002 08:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261677AbSJQMdU>; Thu, 17 Oct 2002 08:33:20 -0400
Received: from p50847823.dip.t-dialin.net ([80.132.120.35]:59013 "HELO
	hermes.zoffice.de") by vger.kernel.org with SMTP id <S261668AbSJQMdS>;
	Thu, 17 Oct 2002 08:33:18 -0400
Subject: increasing blocksizes decrease performance in Gbit
From: Zoltan Bogdan <zoltan.bogdan@t-online.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Oct 2002 14:38:59 +0200
Message-Id: <1034858339.13137.3.camel@hermes>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


does anyone know about the performace impact whereabouts of different 
blocksizes?

I'm using kernel 2.4.18 on a machine with 512MB Ram and two 3Ware
Escalade 
7850 controllers with an 8-Disk (hardware- )RAID 5  array on each. 

A softraid 0 Array spans  those two Raidarrays.     


While doing some benchmarks over Gbit Network I experianced the
following:
  
Block | Read Lin | Read Rnd | Write Lin
 kB   |  MB/sec  |  MB/sec  |  MB/sec  
------+----------+----------+-----------
   16 |    25.9  |     3.3  |    12.1
   32 |    31.5  |     6.6  |    17.8
  256 |    15.4  |    13.2  |    21.3
 1024 |    13.7  |    20.8  |    21.4

Any clue why the value for linear read decreases when the Blocksizes get
higher?

I thought the contrary to be true.

I apologize if my question I to off topic.


Thanks 
z

