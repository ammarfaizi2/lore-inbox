Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130134AbRBPKH6>; Fri, 16 Feb 2001 05:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130262AbRBPKHi>; Fri, 16 Feb 2001 05:07:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3343 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130134AbRBPKH0>; Fri, 16 Feb 2001 05:07:26 -0500
Subject: Re: PATCH: linux-2.4.2-pre3/arch/i386/boot/Makefile breaks with binutils-2.10.1.0.7
To: adam@yggdrasil.com (Adam J. Richter)
Date: Fri, 16 Feb 2001 10:07:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20010215230836.A10861@adam.yggdrasil.com> from "Adam J. Richter" at Feb 15, 2001 11:08:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Thna-0002iL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	The "ld" program in binutils-2.10.1.0.7 and in
> binutils-2.10.91.0.2 now requires "--oformat" instead of "-oformat".
> This breaks linux-2.4.2-pre3/arch/i386/boot/Makefile.  I have attached
> the fix below.  I am running a kernel built with this updated Makefile.

There's a fix in -ac already. I'm just waiting for linus to put out a 2pre4
so I can start feeding him more stuff

