Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130641AbQKBA4W>; Wed, 1 Nov 2000 19:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132023AbQKBA4M>; Wed, 1 Nov 2000 19:56:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29740 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130641AbQKBA4E>; Wed, 1 Nov 2000 19:56:04 -0500
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
To: npsimons@fsmlabs.com
Date: Thu, 2 Nov 2000 00:56:40 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), garloff@suse.de, jamagallon@able.es,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001101171158.A4708@fsmlabs.com> from "Nathan Paul Simons" at Nov 01, 2000 05:11:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13r8gM-00013x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	So other distro's did it too.  Why did nobody complain till RedHat
> did it?  Because no one else decided to use, as the default, a bleeding edge 
> compiler that not only won't compile the kernel but won't even touch a lot of 
> userspace code either.

Actually the first people to do exactly that were Debian, who shipped a compiler
that couldnt reliably build a kernel for the time period. Thats one of the
reasons they put in gcc272. 

Its good sense to tie large critical pieces of hard to validate code to the
compiler. There is a reason you'll find any good software company maintains
old releases in archives with the build environment to reproduce them exactly


Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
