Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSGCTE7>; Wed, 3 Jul 2002 15:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSGCTE6>; Wed, 3 Jul 2002 15:04:58 -0400
Received: from linux.kappa.ro ([194.102.255.131]:6636 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S317181AbSGCTE4>;
	Wed, 3 Jul 2002 15:04:56 -0400
Date: Wed, 3 Jul 2002 22:09:31 +0300
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: eth0: memory shortage
Message-ID: <20020703190931.GA13103@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I keep getting these messages (like about twice a day) in the messages:
eth0: memory shortage
eth0: memory shortage
eth1: memory shortage
eth1: memory shortage


Any idea what could be the reason behind this?

I have the following hardware/software configuration:

XP 2000+ / KT333 (Soltek DRV5) / 512MB DDR PC2100
2 x 3Com 3c905 NICs


The kernel is 2.4.19-pre10 with netfilter for bridging patch
applied and it is configured as a bridge between 2 routers
to do filtering for forwarding and packet scheduling (htb)
it has a throughput of 17Mbps, 900 entries in FORWARD chain,
and 700 classes in htb on each card.

Anyway my real question is if I should be worried about 
those messages? and of course any solutions if this is a
problem?



-- 
      Teodor Iacob,
Astral TELECOM Internet
