Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaOFc>; Sun, 31 Dec 2000 09:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLaOFW>; Sun, 31 Dec 2000 09:05:22 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40716 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129324AbQLaOFM>; Sun, 31 Dec 2000 09:05:12 -0500
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Sun, 31 Dec 2000 13:37:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <20001231113423.A5146@emma1.emma.line.org> from "Matthias Andree" at Dec 31, 2000 11:34:23 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14CifW-000818-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	while { true } do cat /proc/apm done
> > 
> > made the box visibly stall and jerk doing X operations
> 
> Ok, now, what can be done about the stall? I assume nothing serious.

Nothing much

> Is there at least away we can recover the proper system time after these
> stalls?

If you have a tsc on your chip - I think most modern laptops will do as they
tend to be pentium/mmx k6 or pII/pIII processors, then you can check the 
elapsed CPU cycles and recover the jiffies from that. Might be an interesting
exercise for someone


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
