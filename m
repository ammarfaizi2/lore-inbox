Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310362AbSCLCpl>; Mon, 11 Mar 2002 21:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310361AbSCLCpV>; Mon, 11 Mar 2002 21:45:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11538 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310359AbSCLCpO>; Mon, 11 Mar 2002 21:45:14 -0500
Subject: Re: [patch] My AMD IDE driver, v2.7
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 12 Mar 2002 02:57:17 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), davidsen@tmr.com (Bill Davidsen),
        linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <3C8D5CCD.3050208@mandrakesoft.com> from "Jeff Garzik" at Mar 11, 2002 08:41:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kcTV-0002ar-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are such random vendor-specific commands really that common?

Not very

> Linus, would it be acceptable to you to include an -optional- filter for 
> ATA commands?  There is definitely a segment of users that would like to 
> firewall their devices, and I think (as crazy as it may sound) that 
> notion is a valid one.

Jeff -I like the idea of the filters - but if the ATA command raw stuff
is CAP_SYS_RAWIO then its the same right set as inb/outb. Beyond that
its a job for the NSA and RSBAC stuff ?
