Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264735AbRF1VtG>; Thu, 28 Jun 2001 17:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264692AbRF1Vs5>; Thu, 28 Jun 2001 17:48:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26385 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264561AbRF1Vsj>; Thu, 28 Jun 2001 17:48:39 -0400
Subject: Re: VIA 686B/Data Corruption
To: ryan@guardiandigital.com (Ryan W. Maple)
Date: Thu, 28 Jun 2001 22:48:32 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jlaako@pp.htv.fi (Jussi Laako),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.10.10106281741070.11750-100000@mastermind.inside.guardiandigital.com> from "Ryan W. Maple" at Jun 28, 2001 05:41:57 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FjeK-0007hz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Interesting. They should be the same code for the VIA driver.
> 
> I remember hearing something about Red Hat disabling UDMA on VIA chips
> across the board.  Maybe that has something to do with it?

The RH 7.1 kernel disables VIA UDMA if the board has a DMI string indiciating
its a KT7 or KT7RAID. The errata kernel applies the fixups that people deduced
by hacking on the VIA stuff

Alan

