Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSJYOBh>; Fri, 25 Oct 2002 10:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbSJYOBg>; Fri, 25 Oct 2002 10:01:36 -0400
Received: from [217.107.92.11] ([217.107.92.11]:52114 "EHLO gateway.com2t.com")
	by vger.kernel.org with ESMTP id <S261416AbSJYOBg> convert rfc822-to-8bit;
	Fri, 25 Oct 2002 10:01:36 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Serge <sergeyssv@mail.ru>
Organization: Kom2T
To: linux-kernel@vger.kernel.org
Subject: VIA EPIA problem
Date: Fri, 25 Oct 2002 19:00:02 +0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210251900.02065.sergeyssv@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mainboard VIA EPIA mini-ITX with VIA C3 800 Mhz or 500 Mhz

I faced with strange problem connected to this mainboard.

Kernel crashed when attempt to configrue net interface. 

I tried to make linux terminal based on this mainboard.
I use diet-pc project as base for this approach - diet-pc.sourceforge.net.
Kernel crashed when 'pump' tried to configure eth0 via dhcp.
Kernel also crashed when it tried to configure eth0 via dhcp ( CONFIG_IP_PNP & 
CONFIG_IP_PNP_DHCP ).

This problem occured _very_ rarely. ( about 1 time of 12-20 start/reboots of 
computer)
Driver used : via-rhine.
I also tried driver from VIA (linuxfet.c) . Result is same.
I tried various 2.2 - 2.4 kernels  ( including last pre11 patch ).
And when net interface configured it works fine.
I tried 4(!) mainboards.

The problem disappeared when I disabled on board LAN  
and install Realtek 8139C NIC. 

So I think that problem in driver.  Am I right ?

Can somebody help me or comment this problem?

Regards,
	Serge.
