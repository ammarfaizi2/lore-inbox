Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAEUuH>; Fri, 5 Jan 2001 15:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbRAEUt6>; Fri, 5 Jan 2001 15:49:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1800 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129561AbRAEUtn>; Fri, 5 Jan 2001 15:49:43 -0500
Subject: Re: Module section warning
To: jamagallon@able.es (J . A . Magallon)
Date: Fri, 5 Jan 2001 20:51:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20010105210616.A872@werewolf.able.es> from "J . A . Magallon" at Jan 05, 2001 09:06:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Edq0-0008PC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o  binutils               2.9.1.0.25              # ld -v
> o  modutils               2.4.0                   # insmod -V
> 
> and 2.4 uses gas instead of as86 for real mode.
> 
> Are not that versions enough to delete the
> __asm__(".section .modinfo\n\t.previous");
> in module.h ?

Firstly they are guidelines for x86. Secondly certain configs need the updates
so its pretty invasive to force it yet - 2.5.0 yes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
