Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRDJLCm>; Tue, 10 Apr 2001 07:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbRDJLCc>; Tue, 10 Apr 2001 07:02:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38148 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129242AbRDJLCW>; Tue, 10 Apr 2001 07:02:22 -0400
Subject: Re: Version 6.1.11 of the aic7xxx driver availalbe
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Tue, 10 Apr 2001 12:03:05 +0100 (BST)
Cc: wakko@animx.eu.org (Wakko Warner), linux-kernel@vger.kernel.org
In-Reply-To: <200104100234.f3A2YFs23361@aslan.scsiguy.com> from "Justin T. Gibbs" at Apr 09, 2001 08:34:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mvvQ-0003zl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >So, what about on an alpha system.  I've asked a few times what I could do,
> >but you didn't help nor explain what you meant.
> 
> From talking to the maintainer of the QLogic driver, it appears
> that there is a generic issue with data mapping on the Alpha.
> The only way to correct this issue will be for someone to debug
> it.

This seems to be the case for some Alpha boxes. On these aic7xxx dies with
2.4 but then so does IDE DMA for example. The real test would be to run
Justin's 2.2.19 patch driver and see if that works on Alpha.

