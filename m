Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289830AbSAKHDZ>; Fri, 11 Jan 2002 02:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSAKHDP>; Fri, 11 Jan 2002 02:03:15 -0500
Received: from x86unx3.comp.nus.edu.sg ([137.132.90.3]:19637 "EHLO
	x86unx3.comp.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S289830AbSAKHDB>; Fri, 11 Jan 2002 02:03:01 -0500
Date: Fri, 11 Jan 2002 15:02:56 +0800 (GMT-8)
From: Zhu Ying Jie <zhuyingj@comp.nus.edu.sg>
To: linux-kernel@vger.kernel.org
Subject: Tunnel network interface and Sock
Message-ID: <Pine.GSO.4.21.0201111500030.16742-100000@sf3.comp.nus.edu.sg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I got several questions about the structures in TCP/IP implementation
in Linux kernel version 2.4.2.
   1. In freebsd, there is structure called "tun_softc" which controls the
interface property of the tunnel network. In Linux, i just found structure
of "net_device" doing same thing for all the network device. I am
wondering if there is some structures which directly controls the tunnel
network instead of the general network device? E.g. I want to get the info
whether the interface has packet in its sending queue.
   2. I am wondering in linux whether ALL the sending or receiving tcp
"sock" are linked together as a link list? And how can I find the first
element in the list?
   Please cc the reply to zhuyingj@comp.nus.edu.sg and thanks a lot for
the help.


Zhu Ying jie
Department of Computer Science,
School of Computing, 
National University of Singapore


SS****************************SS***********************************SS
+           From little town of far land we came,                   + 
+           to save our honor from a world of flame.                +
+           By little town of far land we sleep,                    + 
+           and trust that world will be won for you to keep.       +
SS****************************SS***********************************SS

