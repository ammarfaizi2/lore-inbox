Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137103AbREKKpq>; Fri, 11 May 2001 06:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137104AbREKKpP>; Fri, 11 May 2001 06:45:15 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12552 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S137103AbREKKpN>; Fri, 11 May 2001 06:45:13 -0400
Subject: Re: Problem with dmfe
To: L.A.Timochouk@ukc.ac.uk (Leonid Timochouk)
Date: Fri, 11 May 2001 19:01:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105102040080.23395-100000@myrtle.ukc.ac.uk> from "Leonid Timochouk" at May 10, 2001 08:46:56 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yHEE-0000kr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> server (600MHz Celeron), and strange effects occurred with the Davicom DM9102
> network card. It was active but apparently VERY slow, 85% packet loss in ping.
> I could connect to the machine but could not do anything useful. The system had
> to be rebooted into the previous configuration (2.2.12) which works fine.

It could be an IRQ routing problem. It could be a dmfe driver problem. Does
using the tulip driver in 2.4.x with it make it any happier ?

> Thus, device 00:01.0 (video card) shares IRQ with the net card. Could it be
> the source of the problem? Under 2.2.12, pciutils show the following info
> for these devices:

PCI irq sharing is part of the spec.

> Thus, it says IRQ for the VGA card is 0, not 3 (also strange).

[VGA one is disabled I think]

