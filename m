Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbSJYPz2>; Fri, 25 Oct 2002 11:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbSJYPz2>; Fri, 25 Oct 2002 11:55:28 -0400
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:14215 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S261454AbSJYPz1>; Fri, 25 Oct 2002 11:55:27 -0400
Date: Fri, 25 Oct 2002 09:01:37 -0700 (PDT)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: LKML <linux-kernel@vger.kernel.org>
cc: jgarzik@mandrakesoft.com
Subject: 2.5.44-ac2 8139too WOL: can't power down onboard device
Message-ID: <Pine.LNX.4.44.0210250846300.28368-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using 2.5.44-ac2 with the 8139too driver on an ECS K7VT3A motherboard
with onboard Ethernet:

00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10).  

I find that whenever I power down this machine, the Ethernet controller
stays powered on according to my hub.  This is even though ethtool says
that WOL is disabled, as below.  Is there any way to power down the
Ethernet controller on this board?  Any suggestions would be appreciated.

Cheers,
Wayne

[root@pizza root]# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 32
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: pumbg
        Wake-on: d
        Current message level: 0xffffffff (-1)
        Link detected: yes






