Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbQKBLq0>; Thu, 2 Nov 2000 06:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130784AbQKBLqR>; Thu, 2 Nov 2000 06:46:17 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18490 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130485AbQKBLqE>; Thu, 2 Nov 2000 06:46:04 -0500
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
To: Wayne.Brown@altec.com
Date: Thu, 2 Nov 2000 11:46:34 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), npsimons@fsmlabs.com, garloff@suse.de,
        jamagallon@able.es, linux-kernel@vger.kernel.org
In-Reply-To: <8625698B.00200009.00@smtpnotes.altec.com> from "Wayne.Brown@altec.com" at Nov 01, 2000 11:46:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rIpI-0001SY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ppp and setiathome with no problems.  Instead of using two compilers, why not
> stay with the older version for everything and not use the latest gcc for
> anything until both the kernel and userland stuff can be compiled with it?

egcs-1.1.2 is a reasonable C compiler. It makes a few errors under register
pressure and stuff. However its at best 'a C++ subset compiler'. 2.95 is a
fair bit better.

Most of these problems are also not the compiler but applications. gcc 2.95 
broke a lot of asm using code because the apps were wrong. Without the pain
they would simply never get fixed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
