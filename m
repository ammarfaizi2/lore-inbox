Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289080AbSA1BSQ>; Sun, 27 Jan 2002 20:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289081AbSA1BSE>; Sun, 27 Jan 2002 20:18:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13580 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289080AbSA1BR5>; Sun, 27 Jan 2002 20:17:57 -0500
Subject: Re: 2.4.18-pre7 slow ... apm problem
To: jdthood@mail.com (Thomas Hood)
Date: Mon, 28 Jan 2002 00:32:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au (Stephen Rothwell)
In-Reply-To: <1012176940.2576.102.camel@thanatos> from "Thomas Hood" at Jan 27, 2002 07:15:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Uzie-0003Ba-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1) keyboard rate is a bit slow on 2.4.18-pre7 compared to
> >    2.4.18-pre6.
> > 2) On vmware 3.0, ping localhost is very slow. 2.4.18-pre6
> >    has not such problem.
> >
> > After disabling CONFIG_APM_CPU_IDLE, the system works fast again.
> > With pre6 or earlier versions, system works fine though even with
> > CONFIG_APM_CPU_IDLE enabled.
> 
> Idle handling in the apm driver was modified in 2.4.18-pre7 .
> Back to the drawing board ...

The keyboard rate one is curious. The vmware one I can easily believe is
caused by Vmware switching in/out of OS's without managing the APM
state of the processor (and leaving it in powersave)

Not sure its drawing board time, just a little investigation.

Alan
