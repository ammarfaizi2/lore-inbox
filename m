Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313302AbSDGNRP>; Sun, 7 Apr 2002 09:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313304AbSDGNRO>; Sun, 7 Apr 2002 09:17:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49157 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313302AbSDGNRN>; Sun, 7 Apr 2002 09:17:13 -0400
Subject: Re: WatchDog Driver Updates
To: rob@osinvestor.com (Rob Radez)
Date: Sun, 7 Apr 2002 14:34:06 +0100 (BST)
Cc: rmk@arm.linux.org.uk (Russell King), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204070624470.3791-100000@pita.lan> from "Rob Radez" at Apr 07, 2002 06:35:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uCo2-000632-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 5. WDIOC_GETSTATUS is supposed to return the WDIOF_* flags.  Returning
> >    "watchdog active" as bit 0 causes it to indicate WDIOF_OVERHEAT.
> 
> Hmm...I'm not seeing any standards here.  Some drivers would just send

Documentation/* in current -ac
