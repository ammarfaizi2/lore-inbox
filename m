Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLHAqP>; Thu, 7 Dec 2000 19:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQLHAqG>; Thu, 7 Dec 2000 19:46:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11278 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129352AbQLHApz>; Thu, 7 Dec 2000 19:45:55 -0500
Subject: Re: cyrix III by via
To: estabroo@talkware.net (Eric Estabrooks)
Date: Fri, 8 Dec 2000 00:17:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A3024D4.EDA13485@talkware.net> from "Eric Estabrooks" at Dec 07, 2000 06:01:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144BEP-0003DP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The cyrixIII chips by via have the centaur vendor id which causes the
> identify_cpu call in arch/i386/kernel/setup.c to fail.  It is probably
> reasonable for it to have the centaur id as via owns centaur as well.  I
> just replaced the centaur_model call with the cyrix_model one, but I
> know that I am using a cyrix chip.
> 
> A test probably needs to be added in the centaur_model section to test
> for the cyrixIII in disguise.
> 
> The error is a general protection fault.
> 
> Sorry if this is old hat,

Its fairly new hat. VIA cyrix III is a next generation IDT winchip (VIA bought
both the winchip stuff and the Cyrix stuff). 2.2.18 should handle the
winchip properly

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
