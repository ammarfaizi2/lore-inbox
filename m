Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271367AbRH3JKA>; Thu, 30 Aug 2001 05:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRH3JJu>; Thu, 30 Aug 2001 05:09:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38414 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271367AbRH3JJj>; Thu, 30 Aug 2001 05:09:39 -0400
Subject: Re: kernel compile problems
To: alegator@aduva.com
Date: Thu, 30 Aug 2001 10:13:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B8DFA63.86E13099@aduva.com> from "Alexander Gavrilov" at Aug 30, 2001 11:33:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cNt6-0000mE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to compile kernel 2.2.16-20
> with kgcc :
> kgcc-1.1.2-40
> 
> make[1]: Entering directory `/usr/src/linux-2.2.16/arch/i386/boot'
> kgcc -D__KERNEL__ -I/usr/src/linux/include -E -D__BIG_KERNEL__
> -traditional -DSVGA_MODE=NORMAL_VGA  bootsect.S -o bbootsect.s
> as86 -0 -a -o bbootsect.o bbootsect.s
> make[1]: as86: Command not found

You need dev86 installed too
