Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310287AbSCABOI>; Thu, 28 Feb 2002 20:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310277AbSCABKj>; Thu, 28 Feb 2002 20:10:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59920 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310291AbSCABIF>; Thu, 28 Feb 2002 20:08:05 -0500
Subject: Re: Kernel Panics on IDE Initialization
To: augustus@linuxhardware.org (Kristopher Kersey)
Date: Fri, 1 Mar 2002 01:22:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202272325350.20225-100000@penguin.linuxhardware.org> from "Kristopher Kersey" at Feb 27, 2002 11:34:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gbl9-0001wj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On two seperate motherboards that I have been testing, the ABIT
> KR7A-RAID and the SOYO FIRE DRAGON, 2.4 kernels panic on boot up during
> IDE initialization.  I don't really know how to track down the problem but
> now that I've seen it on two boards I'm a bit worried.  This does not
> happen with 2.2 kernels so it is 2.4 specific.  I have tested with 2.4.17
> and 2.4.18 pre releases.  I will try to field any questions to solve the

Try 2.4.18 proper and 2.4.18-ac2 - we fixed at least one oops caused by
controllers and mishandling of new revisions not in our tables. If it
still fails send me the pci data for them
