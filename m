Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130401AbQL1Msr>; Thu, 28 Dec 2000 07:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132397AbQL1Msg>; Thu, 28 Dec 2000 07:48:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19473 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130401AbQL1MsW>; Thu, 28 Dec 2000 07:48:22 -0500
Subject: Re: Linux 2.2.19pre3
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Thu, 28 Dec 2000 12:20:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001228112305.A2571@emma1.emma.line.org> from "Matthias Andree" at Dec 28, 2000 11:23:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Bc2d-0003e0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wait a minute, this is a new board. I had a suspicion, and I have a new
> suspect, can we investigate this?

Yep

> I rebooted, and since I left APM out, the system clock is alright since
> 63 mins. Might the APM BIOS CPU IDLE calls be related? I did *not* enable

If the APM bios holds interrupts off or doesnt let Linux handle each time
tick.

> CONFIG_APM_ALLOW_INTS. I'll investigate this right now and report back
> what I find.

That would be interesting
> 
> > adjtimex will let you tell Linux the clock on the board is crap too
> 
> Where is the source for the adjtimex /program/? SuSE don't bring
> adjtimex.

tickadj I think is one front end to it

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
