Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312119AbSDNMXk>; Sun, 14 Apr 2002 08:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312181AbSDNMXj>; Sun, 14 Apr 2002 08:23:39 -0400
Received: from amethyst.es.usyd.edu.au ([129.78.124.28]:10942 "EHLO
	amethyst.es.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S312119AbSDNMXi>; Sun, 14 Apr 2002 08:23:38 -0400
Date: Sun, 14 Apr 2002 22:23:36 +1000 (EST)
From: ivan <ivan@es.usyd.edu.au>
To: <linux-kernel@vger.kernel.org>
Subject: Memory Leaking. Help!
Message-ID: <Pine.LNX.4.33.0204142204330.19694-100000@dipole.es.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have posted this to linux-mm list but it is a bit quite there, so I
decided to try this one.

I am running 7.2RedHat kernel 2.4.9-31 on Dell 4400 PowerEdge 
Server. Dual CPU 990MHz.

The machine was a lemon from the start. We paid for it 16000$, to find out 
that one SCSI controller and two SCSI disk were broken out of the box. 

It kept crushing a couple time a months with clear logs. (My Desktop 
Pentium 2 has being running for a year).

Machine is under warranty; Dell replaced mum and both CPUs. Still going
down. They refused to replace RAM (4Gb) asking me to test memory by
swapping RAM around to see if frequency of crushes will decrease/increase.
This is despite all my explanations that it was a production server.

I have to admit: "Buy DELL and you in Hell" this is despite all the good
things Dell developers are doing for the linux community.

10 Days ago I installed DNS and DHCPd servers from RedHat and noticed that 
"top" shows the amount of consumed memory is slowly and constantly 
growing. Machine became unstable and a few users complained that their 
files disappeared. ( we have good backup ). I re-booted 4 days ago and now 
it looks it is doing it again. Could this be BIND?


1) Could you please advice how can I detect memory leaks. ( I guess it is 
not an easy task on production server.

2) Is there a tool which I can use to log memory usage 

3) Any help will be appreciated.


Thank you in advance,
Ivan.



-- 

There's an old story about the person who wished his computer were as
 easy to use as his telephone. That wish has come true, since I no
 longer know how to use my telephone.

================================================================================

Ivan Teliatnikov,
F05 David Edgeworth Building,
Department of Geology and Geophysics,
School of Geosciences,
University of Sydney, 2006
Australia

e-mail: ivan@es.usyd.edu.au
ph:  061-2-9351-2031 (w)
fax: 061-2-9351-0184 (w)

===============================================================================

