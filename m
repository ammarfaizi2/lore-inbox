Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSDEMlw>; Fri, 5 Apr 2002 07:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312532AbSDEMll>; Fri, 5 Apr 2002 07:41:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17414 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312529AbSDEMl2>; Fri, 5 Apr 2002 07:41:28 -0500
Subject: Re: [QUESTION] How to use interruptible_sleep_on() without races ?
To: jt@hpl.hp.com
Date: Fri, 5 Apr 2002 13:58:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux kernel mailing list),
        jgarzik@mandrakesoft.com (Jeff Garzik)
In-Reply-To: <20020404190848.C27209@bougret.hpl.hp.com> from "Jean Tourrilhes" at Apr 04, 2002 07:08:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tTIi-0008GU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > could just use completions in that case or you could use
> > 
> > 	wait_event_interruptible(&my_wait_queue, my_condition==FALSE)
> > 
> > which is a macro that generates the right stuff.
> 
> 	And it might even want to be defined in include/linux/sched.h

It is 8)

Alan
