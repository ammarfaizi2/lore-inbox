Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291253AbSBSLZo>; Tue, 19 Feb 2002 06:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291254AbSBSLZe>; Tue, 19 Feb 2002 06:25:34 -0500
Received: from E0-IBE.r.miee.ru ([194.226.0.89]:11793 "EHLO ibe.miee.ru")
	by vger.kernel.org with ESMTP id <S291253AbSBSLZ1>;
	Tue, 19 Feb 2002 06:25:27 -0500
From: Samium Gromoff <root@ibe.miee.ru>
Message-Id: <200202191412.g1JECvV12317@ibe.miee.ru>
Subject: Re: Ess Solo-1 interrupt behaviour
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 19 Feb 2002 17:12:57 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16d8GI-0000CS-00@the-village.bc.nu> from "Alan Cox" at Feb 19, 2002 11:16:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Alan Cox wrote:"
> 
> > > Thats an esd bug. ESD tries to use ridiculously small fragment sizes
> > > 
> >   Wait, wait, but my ISA Vibra 16 generates 20+ times less interrupts, with the
> >   _same_ esd! 
> 
> Yes. It has diff fragment limits
> 
	So the point is we should fix esd, not the solo-1 driver, i presume?
	(esd_fixed -> irq_load_fixed -> disk_io_is_back)... sounds ok

	EOT

regards, Samium Gromoff

