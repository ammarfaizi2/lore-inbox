Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271836AbRIDP1E>; Tue, 4 Sep 2001 11:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271794AbRIDP0y>; Tue, 4 Sep 2001 11:26:54 -0400
Received: from [209.38.98.99] ([209.38.98.99]:52153 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S271767AbRIDP0l>;
	Tue, 4 Sep 2001 11:26:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fred <fred@arkansaswebs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, rastos@woctni.sk
Subject: Re: Should I use Linux to develop driver for specialized ISA card?
Date: Tue, 4 Sep 2001 10:26:40 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15eHup-0003ir-00@the-village.bc.nu>
In-Reply-To: <E15eHup-0003ir-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01090410264000.14864@bits.linuxball>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm  curious, Alan, Why? I'm a hardware developer, and I would have assumed 
that linux would have been ideal for real time / embedded projects? (routers 
/ controllers / etc.) Is there, for instance, a reason to suspect that linux 
would not be able to respond to interrupts at say 8Khz?
of course I know nothing of rtlinux so I'll read.

TIA
Fred


 _________________________________________________ 
On Tuesday 04 September 2001 10:15 am, Alan Cox wrote:
> > The moving parts of the plotter are controlled by ISA card that generates
> > (and responds to) interrupts on each movement or printing event.
> > The interrupts can be generated quite fast; up to frequency of 4kHz.
>
> Thats fine. The issue you might need to consider is how long you can wait
> between an irq and actually excuting the handler. If that is very tight
> then you may want Victor Yodaiken's rtlinux
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
