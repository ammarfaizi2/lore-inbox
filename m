Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSJYNzE>; Fri, 25 Oct 2002 09:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbSJYNzE>; Fri, 25 Oct 2002 09:55:04 -0400
Received: from kim.it.uu.se ([130.238.12.178]:18626 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261409AbSJYNzD>;
	Fri, 25 Oct 2002 09:55:03 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15801.20136.556691.985301@kim.it.uu.se>
Date: Fri, 25 Oct 2002 16:01:12 +0200
To: Cajoline <cajoline@andaxin.gau.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ASUS TUSL2-C and Promise Ultra100 TX2
In-Reply-To: <Pine.LNX.4.44.0210251530530.4572-100000@andaxin.gau.hu>
References: <Pine.LNX.4.44.0210251530530.4572-100000@andaxin.gau.hu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cajoline writes:
 > I recently setup a box with the following components:
 > Intel Celeron 1300 MHz
 > ASUS TUSL2-C motherboard
 > 2 x Promise Ultra100 TX2 controllers

Those have the 20268 chip, right?

 > Any 2.4 kernel I have tried on this machine displays this strange
 > behavior: any drives attached to the PDC controllers only work at udma
 > mode 2 (UDMA33).

I've recently installed a Ultra133 TX2 (PDC 20269) in a box, and it
also only does UDMA33 in 2.4.20-pre11. 2.5.44 with the PDC driver
for "new" chips does UDMA100, however. (The disk is only UDMA100.)

The latest 2.4.20-pre-ac is supposed to have new IDE drivers, but
I haven't had time to test it myself.

 > So I have come to the conclusion there must be some rather bizarre
 > incompatibility between the PDCs and this motherboard.

Unlikely.

 > Let me note that the PDC controllers do work just fine with other older
 > motherboards. And another thing, during boot-up, the PDCs do show the
 > drives attached to it, detected at the right udma mode.

Did those boards also use standard 2.4 kernels?

/Mikael
