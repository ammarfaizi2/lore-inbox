Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272217AbRIEQLR>; Wed, 5 Sep 2001 12:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272218AbRIEQLH>; Wed, 5 Sep 2001 12:11:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33030 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272217AbRIEQLB>; Wed, 5 Sep 2001 12:11:01 -0400
Subject: Re: kernel panic, a cry for help
To: oscarcvt@galileo.edu
Date: Wed, 5 Sep 2001 17:15:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <999705603.3b964c0359bdc@webmail.galileo.edu> from "oscarcvt@galileo.edu" at Sep 05, 2001 10:00:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15efKa-0006Cj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> im not sure if this q belongs here but i need all the help i can get.
> the www, dns, mail server at my site mysteriously got corrupted (not sure how). 
> Now i boot it up and get
> 
> Kernel panic: No init found. Try passing init= option to kernel
> 
> what can i do? where should i start? i dont want to break anything so please 
> help me,

I suspect back up tapes. The kernel cannot find an /sbin/init to run when
it starts up. That could be on of several things

	-	Disk failure
	-	Someone broke in and erased it all
	-	Misconfiguration

A rescue disk is probably the starting point
