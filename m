Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271643AbRHUMPe>; Tue, 21 Aug 2001 08:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271644AbRHUMPY>; Tue, 21 Aug 2001 08:15:24 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:30482 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S271643AbRHUMPI>; Tue, 21 Aug 2001 08:15:08 -0400
Message-Id: <200108211215.f7LCFMk19783@mail.swissonline.ch>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: Re: kernel threads
Date: Tue, 21 Aug 2001 14:15:14 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <E15XVl6-0006Dr-00@the-village.bc.nu>
In-Reply-To: <E15XVl6-0006Dr-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 August 2001 00:37, you wrote:
> > schedule the call to kernel_thread using tq_schedule
>
> You still want to use daemonzie
>
> > - is there no need to call daemonize in the second variant - if yes why?
>
> A task always has a parent, it'll just be a random task that ran the
> kernel_thread request - in fact it might be a kernel thread and then
> I dont guarantee what will occur. In fact I wouldnt try the tq_schedule one

sorry i didn't say that i what to use 2.4.x
when looking to kernel/context.c there it says that (or better i looks to me 
like it sais) that all that is sheduled to tq_schedule runns under keventd. so
the parent is predicable and is demonised itsself. is that bad or good?

