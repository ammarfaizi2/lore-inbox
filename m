Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130238AbRBAKyI>; Thu, 1 Feb 2001 05:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130232AbRBAKx6>; Thu, 1 Feb 2001 05:53:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41741 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130238AbRBAKxu>; Thu, 1 Feb 2001 05:53:50 -0500
Subject: Re: Etherworks3 driver now obsolete?
To: dtucker@zip.com.au (Darren Tucker)
Date: Thu, 1 Feb 2001 10:54:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200102010822.f118Mlu02001@gate.dodgy.net.au> from "Darren Tucker" at Feb 01, 2001 07:22:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OHNl-00047j-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_OBSOLETE is checked for by Config.in for a couple of drivers (net and
> char), but the only place it seems to be defined is for the ARM architecture. 
> 
> Is this deliberate? Are some of the older drivers to be phased out?
> Should there be a "bool 'Prompt for obsolete code/drivers' CONFIG_OBSOLETE"
> in the config.in for other architectures, too?

You could do but its really there to take out drivers that need fixing and
nobody has yet decided to look at


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
