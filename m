Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSFKTYs>; Tue, 11 Jun 2002 15:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317519AbSFKTYr>; Tue, 11 Jun 2002 15:24:47 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:47744 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317517AbSFKTYr>; Tue, 11 Jun 2002 15:24:47 -0400
Date: Tue, 11 Jun 2002 21:30:47 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: QoS on incoming data
Message-ID: <3D064FE7.mail1Z311DBJT@viadomus.com>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    After reading a bit of the HOWTO about traffic control and
advanced routing, I have a doubt about the queue disciplines and
traffic shaping.

    I've seen that, except the 'ingress' qdisc (and maybe the
hierarchycal token bucket) all other qdisc's seem to be only valid
for outgoing traffic, although I suppose that some of those qdisc
could be easily applied to incoming traffic.

    But the key point is that: I think that the better way of
controlling the incoming bandwidth is the Token Bucket Filter, just
as the autor of the HOWTO says, but I think (may be wrong here) that
the TBF is only valid for outgoing traffic. Moreover, if, just as the
HOWTO says, we set up the TBF for controlling the incoming traffic at,
lets say, 250kb/s for an ADSL access of 256kb/s, it won't control the
outgoing traffic, since the bandwidth of that traffic is just
128kb/s. That is: TBF is not valid if applied to both incoming and
outgoing traffic, and anyway I think that only controls the outgoing
part.

    Please excuse the continous questions about this subject, but I'm
new to this and wanting to understand a bit this powerful feature.

    Thanks in advance :)
    Raúl
