Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266710AbRHCJjB>; Fri, 3 Aug 2001 05:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269386AbRHCJiw>; Fri, 3 Aug 2001 05:38:52 -0400
Received: from host-216-226-192-4.interpacket.net ([216.226.192.4]:62216 "HELO
	iliganet-ipgi.iligan.com") by vger.kernel.org with SMTP
	id <S266710AbRHCJif>; Fri, 3 Aug 2001 05:38:35 -0400
Date: Fri, 3 Aug 2001 18:02:48 +0800 (PHT)
From: rtviado <root@iligan.com>
X-X-Sender: <root@localhost.localdomain>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: load balancing on more than 1 default routes
In-Reply-To: <3B6A2B9A.6E88D0E8@theOffice.net>
Message-ID: <Pine.LNX.4.33.0108031752040.907-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

	I just want to ask if there is a facility in the kernel that load
balance to different default routes, since i'm using this routes for
uplink purposes only (my downlink is via satellite, it doesn't matter
where i send my packets uplink as long as it reaches the internet
backbone).

for example

	in my box, I have routes as describe below

	destination	gateway		netmask
	default         isp1 		0.0.0.0
	default		isp2		0.0.0.0

Want i want is for the kernel to load balance (e.g round robin) uplink
packets to isp1 and isp2. If this in is not possible in the current
kernel, where in the kernel source files can i start hacking to make this
possible?


TIA
-- 
Rodel T. Viado
System Administrator
Iligan Global Access Network Inc.

You can look at my resume and Online Certification at:
http://www.brainbench.com/transcript.jsp?pid=1404199



