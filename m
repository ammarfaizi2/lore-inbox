Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281320AbRKTUN4>; Tue, 20 Nov 2001 15:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281330AbRKTUNs>; Tue, 20 Nov 2001 15:13:48 -0500
Received: from user-119a3cr.biz.mindspring.com ([66.149.13.155]:35077 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S281320AbRKTUNg>; Tue, 20 Nov 2001 15:13:36 -0500
From: Faux Pas III <fauxpas@trellisinc.com>
To: linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems...
In-Reply-To: <Pine.LNX.3.95.1011120144925.14138A-100000@chaos.analogic.com>
X-Newsgroups: mlist.linux-kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19ext3 (i686))
Message-Id: <20011120201333.832BAA3B90@fancypants.trellisinc.com>
Date: Tue, 20 Nov 2001 15:13:33 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1011120144925.14138A-100000@chaos.analogic.com> you wrote:

> FYI, if you care about the name of your ethernet device, your
> configuration is probably broken. The IEEE station address can

Fwiw, you can also rename your interfaces if you have 
the iproute2 tools and netlink in your kernel.

ip link set eth0 down
ip link set eth1 down
ip link set eth0 name temp
ip link set eth1 name eth0
ip link set temp name eth1
ip link set eth0 up
ip link set eth1 up

-- 
Josh Litherland (fauxpas@trellisinc.com)
 It is by caffeine alone that I set my mind in motion.
  It is by the juice of Mtn Dew that thoughts acquire speed.
