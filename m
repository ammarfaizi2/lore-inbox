Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275615AbRI1BSo>; Thu, 27 Sep 2001 21:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275635AbRI1BSe>; Thu, 27 Sep 2001 21:18:34 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:44419 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S275615AbRI1BSY>;
	Thu, 27 Sep 2001 21:18:24 -0400
Message-ID: <3BB3CFFA.F9021469@candelatech.com>
Date: Thu, 27 Sep 2001 18:18:50 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to debug PCI issues?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with a TYAN Tomcat board (i815, Ghz CPU).  It's in a 1U
machine with a butterfly riser so that I get two riser connections to
one PCI slot.  When I put Intel EEPRO nics in each slot, I can pass
30Mbps of traffic on each NIC without dropping a single packet
(In two days of running).

If I run 20Mbps on one of the DLINK ports, I'm fine, but if I run 10Mbps
on two of the DLINK ports, I start seeing dropped packets on every
interface, and port errors like RX-FIFO.

So, I'm thinking that the DLINK NIC must be screwing up the PCI
bus somehow when more than one of it's interfaces is passing any
significant traffic.  I have been able to run 10Mbps on all 8 ports
of two DLINKs on an Intel EEA2 (i815) board, so I suspect the MB.

Does anyone have any ideas how to go about trouble-shooting this
farther?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
