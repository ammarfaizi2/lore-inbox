Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271682AbRICLqx>; Mon, 3 Sep 2001 07:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271683AbRICLqn>; Mon, 3 Sep 2001 07:46:43 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:10451 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S271682AbRICLqi>; Mon, 3 Sep 2001 07:46:38 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200109031144.f83Bibo26091@sunrise.pg.gda.pl>
Subject: Re: ide_delay_50ms question
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 3 Sep 2001 13:44:37 +0200 (MET DST)
Cc: jani@astechnix.ro (Jani Monoses), linux-kernel@vger.kernel.org
In-Reply-To: <E15dr3W-0001Qw-00@the-village.bc.nu> from "Alan Cox" at Sep 03, 2001 11:34:14 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alan Cox wrote:"
> > as well, because when I insert an IDE compactflash card things stop for a
> > second or so nad I use a modular driver.
> > And I don't know about removable harddrives but isn't the schedule_timeout
> > solution better for them as well?
> 
> Some of the current drivers call it with interrupts disabled. This is one of
> the things that will have to wait until 2.5 is released to really address

AFAIR it (interrupts disabled) is necessary for old pre-IDE 16-bit
controllers.

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
