Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292941AbSCOR2P>; Fri, 15 Mar 2002 12:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSCOR2G>; Fri, 15 Mar 2002 12:28:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53005 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292941AbSCOR14>; Fri, 15 Mar 2002 12:27:56 -0500
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
To: kernel@Expansa.sns.it (Luigi Genoni)
Date: Fri, 15 Mar 2002 17:43:38 +0000 (GMT)
Cc: thunder@ngforever.de (Thunder from the hill), linux-kernel@vger.kernel.org,
        nitrax@giron.wox.org (Martin Eriksson)
In-Reply-To: <Pine.LNX.4.44.0203151716120.30388-100000@Expansa.sns.it> from "Luigi Genoni" at Mar 15, 2002 05:52:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lvju-0004Bj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hardware RAID is indeed better, but what you get using HPT370 IDE
> controlelr is not hardware raid at all. Just read the code of the driver.
> You get a software raid, period.

Its not always that simple either.

Software raid on aic7xxx totally blows away the Dell/AMI megaraid card I
have, to the point the megaraid now resides in my testing bucket. The promise
Supertrak 100 (now superceded by the SX6000) is also slower than the
software IDE raid, but does use less CPU in RAID5 mode.

Some hardware raid cards do seem to be winners. The Dell Perc2/QC aacraid
based boards (233Mhz ARM etc) really shift. When I've had the chance to
borrow the disks to test I've seen it running over 100Mbytes/second. It
also supports nice stuff like online reconfiguration of active volumes.
[$$stupid from Dell $$notalot from ebay ;)]

Alan
