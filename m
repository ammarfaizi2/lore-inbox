Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRBKUXW>; Sun, 11 Feb 2001 15:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130051AbRBKUXM>; Sun, 11 Feb 2001 15:23:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7438 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130006AbRBKUWy>; Sun, 11 Feb 2001 15:22:54 -0500
Subject: Re: Re[2]: Where are you going with 2.4.x?
To: akorud@polynet.lviv.ua
Date: Sun, 11 Feb 2001 20:23:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14711049588.20010211200148@polynet.lviv.ua> from "Andriy Korud" at Feb 11, 2001 08:01:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14S321-0004uq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan> driver. Also did you build the DAC960 support with gcc 2.96-x x<74 ?
> My system compiler is:
>    gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
> Shoud I upgrade it to gcc 2.95.x or 2.96.x?

No that one is fine. I have a known problem with DAC960 and cvs gcc or
gcc 2.96.x x<74 where struct sizes change and it doesnt work.

> On the next crash I'll try write down all traces.
> BTW, is there some way to log it somewhere to file?

On a crash we don't log it to a file. The problem is that you cannot be
sure of the state of the system so your logging might itself crash or
do more harm.

The important bit is the EIP value and the call trace.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
