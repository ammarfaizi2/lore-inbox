Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUIAMSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUIAMSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 08:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUIAMSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 08:18:51 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:46502 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266244AbUIAMSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 08:18:36 -0400
Message-ID: <4699bb7b04090105182c5591a9@mail.gmail.com>
Date: Thu, 2 Sep 2004 00:18:35 +1200
From: Oliver Hunt <oliverhunt@gmail.com>
Reply-To: Oliver Hunt <oliverhunt@gmail.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Time runs exactly three times too fast
Cc: Romain Moyne <aero_climb@yahoo.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409010814580.4481@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409021453.09730.aero_climb@yahoo.fr> <Pine.LNX.4.58.0409010814580.4481@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it just me or the bogomips rating listed there completely out of whack?

I'll note however I don't have a kernel 2.6 box lying anywhere nearby,
but I shouldn't have thought the way the bogomips rating is counted
would have changed.

Anyhoo my understanding is that bogomips are used for timing in a few
obscure circumstances -- maybe this could be causing the problems?  (I
would have though about 10x higher would be more correct)

--Oliver Hunt

On Wed, 1 Sep 2004 08:15:55 -0400 (EDT), Zwane Mwaikambo
<zwane@linuxpower.ca> wrote:
> On Thu, 2 Sep 2004, Romain Moyne wrote:
> 
> > Hello, I'm french, sorry for my bad english :(
> >
> > I have a problem with my kernel: Time runs exactly three times too fast.
> >
> > I tested the kernel 2.6.8.1 and the 2.6.9-rc1, no success.
> > It is really strange because yesterday I reinstalled my debian with a kernel
> > 2.6.8.1 (made by me): Time ran correctly. And this morning when I rebooted my
> > computer (Compaq presario R3000 series, R3215EA exactly) the time is running
> > again three times too fast (with the kernel 2.6.8.1 and 2.6.9-rc1).
> >
> > All my applications (KDE, command "date"...) runs three times too fast. It's
> > very annoying.
> 
> Can you try this without cpuspeed or some frequency control daemon
> running? So disable it in runlevel scripts and then reboot.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
