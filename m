Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269413AbRHLUNl>; Sun, 12 Aug 2001 16:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269417AbRHLUNb>; Sun, 12 Aug 2001 16:13:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19215 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269413AbRHLUN2>; Sun, 12 Aug 2001 16:13:28 -0400
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
To: manuel@mclure.org (Manuel McLure)
Date: Sun, 12 Aug 2001 21:15:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <20010812113142.G948@ulthar.internal.mclure.org> from "Manuel McLure" at Aug 12, 2001 11:31:42 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15W1eR-000691-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2001.08.12 05:04 Alan Cox wrote:
> > The in kernel one seemed fine. The 2.4.8 update one is definitely broken
> > on
> > SMP boxes
> 
> I'm getting 2.4.8 Oopsen that seem to be in emu10k1 code on UP - see my
> message "2.4.8 oops in ksoftirqd_CPU0"...

Yep. So far the new driver that Linus took from a non maintaier breaks

	SMP
	Some mixers
	Uniprocessor with some cards
	Surround sound (spews noise on cards)

so I think Linus should do the only sane thing - back it out. I'm backing
it out of -ac. Of my three boxes, one spews noise, one locks up smp and
one works.

Alan
