Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKHX5r>; Wed, 8 Nov 2000 18:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKHX5i>; Wed, 8 Nov 2000 18:57:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40767 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129033AbQKHX5a>; Wed, 8 Nov 2000 18:57:30 -0500
Subject: Re: Linux 2.4.0test11pre1ac1
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 8 Nov 2000 23:58:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3A09E3E5.7A8EB9DB@mandrakesoft.com> from "Jeff Garzik" at Nov 08, 2000 06:38:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tf6v-0000cW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * CARDBUS is never defined.  Should that be CONFIG_CARDBUS?

Yep

> * just increment the version number.  There's no need to add "a" on the
> end...  this version number just differentiates us from the 'canonical'
> Donald Becker version of epic100.c.

Ok

> net/atm/pvc:  return the error value from sock_register, not toss it
> away.

> 
> 
> ramfs comments:

Note: the ramfs changes are in there for one reason only - that Im hacking
on some bits with a pda type box and I cannot be bothered to keep two
sets of trees

> That's one API change we shouldn't throw in without discussion, IMHO...
> it screams "ramfs-specific hack in core code!"

Absolutely

> And finally, don't you need to EXPORT_SYMBOL pm_devs_lock ?

Yep


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
