Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbREPGPm>; Wed, 16 May 2001 02:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261797AbREPGPc>; Wed, 16 May 2001 02:15:32 -0400
Received: from www.wen-online.de ([212.223.88.39]:9747 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261796AbREPGPT>;
	Wed, 16 May 2001 02:15:19 -0400
Date: Wed, 16 May 2001 08:15:11 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove silly beep macro from pgtable.h
In-Reply-To: <p05100314b72729920e83@[207.213.214.37]>
Message-ID: <Pine.LNX.4.33.0105160807190.904-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Jonathan Lundell wrote:

> At 7:36 PM +0200 2001-05-15, Mike Galbraith wrote:
> >On Tue, 15 May 2001, Jeff Golds wrote:
> >
> >>  Hi folks,
> >>
> >>  Found this bit of unused code in the i386 and sh architectures.
> >>As it's not being used, let's get rid of it.  Also, pgtable.h seems
> >>to be an odd place for this.
> >
> >I'd leave it.. folks with early boot troubles might find it useful.
> >
> >	-Mike
>
> Consider small rant about literal IO references to magic locations
> hereby ranted. Especially in header files completely unrelated to the
> IO function in question.
>
> -#define __beep() asm("movb $0x3,%al; outb %al,$0x61")
>
> Let's please not assume that every i386 implementation has a full set
> of legacy PC IO hardware.

Is there a generic form of hello() that could be tucked away somewhere?

	-Mike

