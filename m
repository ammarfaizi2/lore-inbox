Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLaNcg>; Sun, 31 Dec 2000 08:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLaNcR>; Sun, 31 Dec 2000 08:32:17 -0500
Received: from mailframe.cabinet.net ([213.169.1.9]:5132 "HELO
	mailframe.cabinet.net") by vger.kernel.org with SMTP
	id <S129370AbQLaNb4>; Sun, 31 Dec 2000 08:31:56 -0500
Date: Sun, 31 Dec 2000 15:01:09 +0200 (EET)
From: Jussi Hamalainen <count@theblah.org>
To: <linux-kernel@vger.kernel.org>
Subject: path MTU bug still there?
Message-ID: <Pine.LNX.4.30.0012311449250.9644-100000@shodan.irccrew.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an old 486-box acting as a router. It has two NICs and
an ISDN adapter. The box is connected to my ISP by ISDN link
and has a GRE tunnel running over the ISDN link. The other end
of the tunnel is a Cisco router and the tunnel is the default
route. I'm experiencing problems identical to the classic MTU
problem with IP masquarade where a TCP-connection to/from some
hosts becomes jammed after a few bytes have been sent. The only
difference is that the problem is reproducable also on the router
box itself.

I'm running 2.2.18 vanilla and my firewall rules aren't blocking
ICMP. The ethernet interfaces and the ISDN link have an MTU of
1500 and the GRE tunnel has an MTU of 1514 (courtesy of Cisco).

Has anyone got any bright ideas how to work around this? Would
upgrading to 2.4 fix this?

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.org ]=-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
