Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbSADQ5d>; Fri, 4 Jan 2002 11:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288686AbSADQ5X>; Fri, 4 Jan 2002 11:57:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5380 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288684AbSADQ5T>; Fri, 4 Jan 2002 11:57:19 -0500
Subject: Re: Error loading e1000.o - symbol not found
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Fri, 4 Jan 2002 17:08:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0201041739220.29376-200000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Jan 04, 2002 05:45:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MXpL-0004ld-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: unresolved symbol _mmx_memcpy
> /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: insmod /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o failed
> /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: insmod e1000 failed
> 
> What's this? Is _mmx_memcpy only valid on Intel architecture? Does Athlon
> have any equivalent system call?

Looks like you built the module against a different Athlon tree ?
