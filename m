Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283394AbRK2VF1>; Thu, 29 Nov 2001 16:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283395AbRK2VE0>; Thu, 29 Nov 2001 16:04:26 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:27909 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S283392AbRK2VEO>;
	Thu, 29 Nov 2001 16:04:14 -0500
Date: Thu, 29 Nov 2001 23:04:35 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
cc: Rajasekhar Inguva <irajasek@in.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFC: ethernet links should remember routes the same as addresses
Message-ID: <Pine.LNX.4.33.0111292259090.1390-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Christopher Friesen wrote:

> the addresses are still visible associated with the link.  Then I run "ip link
> set dev ethX up".  The route in the main routing table comes back, but none of
> the other routes do.  Somehow, all of those additional routes must be re-added.

	One solution is already implemented: static routes

http://www.linuxvirtualserver.org/~julian/
Static, Alternative Routes, Dead Gateway Detection, NAT

Read about the motivation here:
http://www.linuxvirtualserver.org/~julian/dgd-usage.txt

More specific pathes:
00_static_routes-2.2.19-4.diff
00_static_routes-2.4.12-5.diff

Regards

--
Julian Anastasov <ja@ssi.bg>

