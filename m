Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132738AbRDDDTA>; Tue, 3 Apr 2001 23:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132741AbRDDDSu>; Tue, 3 Apr 2001 23:18:50 -0400
Received: from [64.3.14.3] ([64.3.14.3]:18585 "HELO daveb.net")
	by vger.kernel.org with SMTP id <S132738AbRDDDSk>;
	Tue, 3 Apr 2001 23:18:40 -0400
Date: Tue, 3 Apr 2001 20:21:54 -0400 (EDT)
From: Dave Bailey <dave@daveb.net>
To: <linux-kernel@vger.kernel.org>
Subject: Multicast tunneling in 2.4
Message-ID: <Pine.LNX.4.33L2.0104032013230.7594-100000@sydney.daveb.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to set up a tunnel from my linux machine to the MBone.

My kernel (2.4.2) supports multicasting and advanced routing:

CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MROUTE=y

I have read http://www.linuxdoc.org/HOWTO/Multicast-HOWTO.html
and  http://www.linuxdoc.org/HOWTO/Adv-Routing-HOWTO.html.
Unfortunately, Section 7 of the Advanced Routing HOWTO
(Multicast routing) says:

  "FIXME: Editor Vacancy! (somebody is working on it, though)"

Suppose I know the IP address of a nearby multicast router and would
like to set up a tunnel from my machine to that router (a tunnel to
the MBone), so that I may receive multicast datagrams in spite of the
fact that intervening routers are ignorant of multicast routing
protocols.  Is this possible with the 2.4.2 kernel?  I cannot find
documentation to this effect, but the existence of <linux/mroute.h>
(which contains some structs previously defined in mrouted) makes me
think that it is possible.

--
Dave Bailey
dave@daveb.net



