Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTARHRl>; Sat, 18 Jan 2003 02:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTARHRl>; Sat, 18 Jan 2003 02:17:41 -0500
Received: from pcp01871097pcs.derbrn01.mi.comcast.net ([68.42.47.36]:4356 "EHLO
	uncompiled.com") by vger.kernel.org with ESMTP id <S263204AbTARHRk>;
	Sat, 18 Jan 2003 02:17:40 -0500
Subject: i810_audio problems
From: "Matthew J. Fanto" <mattjf@uncompiled.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 17 Jan 2003 21:20:40 -0500
Message-Id: <1042856440.713.4.camel@chandler>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having problems with the i810_audio driver and the ICH3 chipset. 

When playing audio, it skips VERY badly. After stopping the audio, I get
the message:
drain_dac, dma timeout?

The system is responsive during the skipping, so I doubt it's just high
load. I am using 2.4.20-pre3-ac4 right now, but it also occurs on 2.4.20
and 2.4.21-pre3. 

The i810_audio driver in 2.5 works.  

There are no other kernel messages about audio, just drain_dac, dma
timeout? 

Any help with this would be appreciated. I will attempt to debug this
further later tonight. 

Regards,
Matthew J. Fanto

