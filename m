Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313479AbSDEURZ>; Fri, 5 Apr 2002 15:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313483AbSDEURE>; Fri, 5 Apr 2002 15:17:04 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:12996 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313479AbSDEURD>;
	Fri, 5 Apr 2002 15:17:03 -0500
Date: Fri, 5 Apr 2002 12:16:52 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [QUESTION] How to use interruptible_sleep_on() without races ?
Message-ID: <20020405121652.B27839@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020404190848.C27209@bougret.hpl.hp.com> <E16tTIi-0008GU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 01:58:44PM +0100, Alan Cox wrote:
> > > could just use completions in that case or you could use
> > > 
> > > 	wait_event_interruptible(&my_wait_queue, my_condition==FALSE)
> > > 
> > > which is a macro that generates the right stuff.
> > 
> > 	And it might even want to be defined in include/linux/sched.h
> 
> It is 8)
> 
> Alan

	*Blush*. Yes it is.

	Jean
