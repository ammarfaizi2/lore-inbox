Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbREXM7v>; Thu, 24 May 2001 08:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261821AbREXM7b>; Thu, 24 May 2001 08:59:31 -0400
Received: from pop.gmx.net ([194.221.183.20]:39199 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261805AbREXM7W>;
	Thu, 24 May 2001 08:59:22 -0400
Message-ID: <005201c0e451$57f91740$093fe33e@host1>
From: "peter k." <spam-goes-to-dev-null@gmx.net>
To: "Adrian V. Bono" <adrianb@ntsp.nec.co.jp>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <003901c0e44d$2de3ea60$093fe33e@host1> <3B0D028F.4B7FBAB0@ntsp.nec.co.jp>
Subject: Re: patch to put IDE drives in sleep-mode after an halt
Date: Thu, 24 May 2001 14:59:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > imho the idea is very good
> > i was already wondering why the kernel doesnt spin down the hds when i
> > shutdown...
> > and its necessary because if you want to move your box the hd heads
should
> > be parked!
> >
> >  - peter k.
>
> Aren't all IDE drives built today auto-parking? Auto-parking became an
> inherent feature in voice coil drives (stepper-motor drives weren't
> auto-parking), and since all drives are voice coil drives, then they
> should auto-park. But i've had problems with some hard drives that were
> spinned down (when Win____ was shutdown)..  if i reset the PC (instead
> of turning it off), the hard drives wouldn't come back on so i'd have to
> do a full shutdown of the machine.

well, my new 40gb ones are auto-parking i think but all the other ones from
last year aren't
and older hardware (although 1 year isnt even old for a hd) should be
supported by the kernel, right?
plus, its really not difficult to implement spinning down the hds before
halt anyway and then the kernel
leaves the system as clean as it was before booting ;) !!

- peter k.

