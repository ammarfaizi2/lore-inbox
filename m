Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSG1Txm>; Sun, 28 Jul 2002 15:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSG1Txm>; Sun, 28 Jul 2002 15:53:42 -0400
Received: from dnvrdslgw14poolA183.dnvr.uswest.net ([63.228.84.183]:59761 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S317258AbSG1Txl>;
	Sun, 28 Jul 2002 15:53:41 -0400
Date: Sun, 28 Jul 2002 13:56:49 -0600 (MDT)
From: Benson Chow <blc+lkml-post@q.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: traffic shaper in 2.4.18 working?
Message-ID: <Pine.LNX.4.44.0207281337330.1415-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(initial conditions)
I have two existing IP addresses on eth0 belonging to the same subnet as a
virtual host.  This machine is a dual CPU box at 450MHz with an Intel
EtherPro 100.

(what I've done)
I've executed:
shapecfg attach shaper0 eth0
shapecfg speed shaper0 19000
ifconfig shaper0 10.0.0.80

However, it seems whenever I subsequently connect to this
machine's 10.0.0.80 from another machine, it still transmits at full
bandwidth of the media and not the 19K (Bytes/sec?) that I expect?

Is this a proper usage of this device or is it a bug?

Thanks,

-bc

