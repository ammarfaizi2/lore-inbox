Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129753AbRBVKo7>; Thu, 22 Feb 2001 05:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129932AbRBVKou>; Thu, 22 Feb 2001 05:44:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40464 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129753AbRBVKoe>; Thu, 22 Feb 2001 05:44:34 -0500
Subject: Re: Very high bandwith packet based interface and performance problems
To: raj@cup.hp.com (Rick Jones)
Date: Thu, 22 Feb 2001 10:20:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), nyet@curtis.curtisfong.org (Nye Liu),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A946F71.69D94D13@cup.hp.com> from "Rick Jones" at Feb 21, 2001 05:46:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Vsrg-0003pw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > TCP _requires_ the remote end ack every 2nd frame regardless of progress.
> 
> um, I thought the spec says that ACK every 2nd segment is a SHOULD not a
> MUST?

Yes its a SHOULD in RFC1122, but in any normal environment pretty much a 
must and I know of no stack significantly violating it.

RFC1122 also requires that your protocol stack SHOULD be able to leap tall
buldings at a single bound of course...

