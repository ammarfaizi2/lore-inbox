Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131654AbRDCMcK>; Tue, 3 Apr 2001 08:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131658AbRDCMb4>; Tue, 3 Apr 2001 08:31:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23301 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131669AbRDCMbs>; Tue, 3 Apr 2001 08:31:48 -0400
Subject: Re: More about 2.4.3 timer problems
To: viking@flying-brick.caverock.net.nz (Eric Gillespie)
Date: Tue, 3 Apr 2001 13:33:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104031038070.4158-100000@brick.flying-brick.caverock.net.nz> from "Eric Gillespie" at Apr 03, 2001 12:56:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kPzx-0007yL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I updated my kernel to 2.4.3 when the patch was released. As I said earlier, I
> noticed my timer losing a few seconds over the space of a couple of
> hours.  Well, I have since found out that the amount of time lost is
> proportional to the load on the machine: the heavier the load, the more time
> lost.
> 
> VESA fb mode 1280x1024x16, clock lost 1m 35s in time
> 996.52 user 166.82 system 23:19.40 elapsed 83% CPU 

The vesafb / clock sliding problem is fixed in the -ac releases.

Alan

