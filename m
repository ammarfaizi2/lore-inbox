Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265227AbUFRP1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUFRP1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUFRP1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:27:30 -0400
Received: from vsmtp1b.tin.it ([212.216.176.141]:27608 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S265264AbUFRPXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:23:20 -0400
Subject: Re: [BUG] 2.6.x ALSA sound is pretty broken
From: Hetfield <hetfield666@virgilio.it>
Reply-To: hetfield666@virgilio.it
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <40D2FA24.50607@vision.ee>
References: <1087567432.9282.17.camel@blight.blight>
	 <40D2FA24.50607@vision.ee>
Content-Type: text/plain; charset=iso-8859-15
Organization: Hetfield
Message-Id: <1087572189.1733.1.camel@blight.blight>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 17:23:10 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il ven, 2004-06-18 alle 16:20, Lenar Lõhmus ha scritto:
> Hello,
> 
> Do you have DMA enabled for your hard disk? hdparm -d /dev/hdx
> will tel you ...
> 
disabling DMA fixes completly the problem.
of course cpu usage is very high without it.
i can't burn cd and speed faster than 4x.

so ide-dma related seems!

> Lenar
> 
> Hetfield wrote:
> 
> >i've got hard problems with sound in all 2.6.x, even 2.6.7 kernels.
> >
> >with 2.4.2x or windows i've got no problems, so i'm sure it's kernel and
> >not hardware related.
> >
> >the problem is that sound jumps, flickers and isn't good when harddisk
> >reads lots of data (i mean not 1-2mb but 60-100mb and more)
> >
> >i checked irq and there is not conflict, i setted a higher and lower
> >value of latency and nothing changed.
> >
> >i've the same problems since 2.6.0 kernels. Vanilla and Gentoo too.
> >I've tried lots of solutions, like disabling preemptile kernel, adding
> >alsa and oss, only oss, only alsa, as module or built-in.
> >nothing changes.
> >
> >my audio card is a Creative SB PCI128, found by linux as
> >
> >
> >0000:00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev
> >01)
> >        Subsystem: Unknown device 4942:4c4c
> >        Flags: bus master, slow devsel, latency 32, IRQ 10
> >        I/O ports at b000
> >
> >while on Windows i use es1371/3 drivers.
> >however with 2.4.x i always used es1370 alsa module without problems.
> >When harddisk is sleeping sound is normally good.
> >
> >Thanks for support
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >  
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

________________________________________________________________________
Hetfield
www.blight.tk

