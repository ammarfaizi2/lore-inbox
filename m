Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269737AbRHIIqZ>; Thu, 9 Aug 2001 04:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269739AbRHIIqP>; Thu, 9 Aug 2001 04:46:15 -0400
Received: from planets.unix-ag.uni-hannover.de ([130.75.176.213]:65038 "EHLO
	planets.unix-ag.uni-hannover.de") by vger.kernel.org with ESMTP
	id <S269737AbRHIIqE>; Thu, 9 Aug 2001 04:46:04 -0400
Date: Thu, 9 Aug 2001 08:45:59 +0000 (GMT)
From: Joerg Habenicht <habenich@planetsserver.com>
Reply-To: Joerg Habenicht <j.habenicht@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: no multicast in ethertap ?
Message-ID: <Pine.LNX.4.21.0108090747270.11184-100000@planets.unix-ag.uni-hannover.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is a question about writing multicast packets to the ethertap device.
If I'm wrong in this list, please point me to the right direction.


I try to send multicast UDP packets to the network layer by writing them
to the ethertap device. To test the network I set up a small application,
which subscribes to a multicast channel. However the packets don't seem to
appear at the multicast listener application while being subscribed to
the channel.

 For testing purpose I made a check against the ethernet card. I did send
the same packets through the LAN and the app showed them correctly.



Is there any restriction I should know of ?
Might there be any configuration I should set additionally ?

Kernel 2.4.{0,2} with ethertap and taptun as modules
ifconfig tap0 15.0.0.10 up arp
or ifconfig tap0 133.x.x.2 up arp


The newer kernel docs says ethertap is considered obsolete.
Does the behavior change when using the tuntap device WRT support
multicast packets ?


Thanks in advance for your time & answers
cu,
Joerg

-- 
THE full automatic planets host
:-)                            http://www.planetsserver.com

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GE/CS/IT d- s+:- a- C++ ULS+++>++++ P++ L+++>++++$ 
E W++ N+(+++) !o? !K? w--(---) !O(++) !M !PS !PE !Y? PGP+ 
t-- 5-- X-- tv+ b++ DI+() D-(+) G>+ e++>+++ h+(*) r% y? UF
------END GEEK CODE BLOCK------
"Alle Menschen sind gleich !"
   "...mir jedenfalls"        Gerd Show


