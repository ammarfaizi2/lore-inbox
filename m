Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135598AbRDSIwT>; Thu, 19 Apr 2001 04:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135596AbRDSIwJ>; Thu, 19 Apr 2001 04:52:09 -0400
Received: from irmgard.exp-math.uni-essen.de ([132.252.150.18]:24330 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S135595AbRDSIwD>; Thu, 19 Apr 2001 04:52:03 -0400
Date: Thu, 19 Apr 2001 10:52:00 +0200 (MESZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Dynamic TCP reserved ports allocated in which range?
Message-Id: <Pine.A32.3.95.1010419104422.13922A-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List(s)

For a firewall setup I need to know in which range applications like
rsh, or better yet the rresvport() libc function allocate reserved ports.

Do I have to expect ports in the whole 1..1024 range (maybe omitting those
already in use by other servers) or is only a limited range used (like
512-1023).

Thanks in advance,
Michael.

P.S.
Yes, I know I shouldn't allow such things through a firewall, but I have
to (at least for now) and it's also not into the internet but only between
internal departments.

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.

