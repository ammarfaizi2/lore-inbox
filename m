Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266207AbUGJKzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266207AbUGJKzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 06:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUGJKzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 06:55:43 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:16216 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266207AbUGJKzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 06:55:41 -0400
Message-ID: <2a4f155d040710035512f21d34@mail.gmail.com>
Date: Sat, 10 Jul 2004 13:55:25 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Cc: Redeeman <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040710085044.GA14262@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040709182638.GA11310@elte.hu> <1089407610.10745.5.camel@localhost> <20040710080234.GA25155@elte.hu> <20040710085044.GA14262@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on 2.6.7-bk20, Pentium3 700 mhz, 576 mb RAM

I did cp -rf big_folder new_folder . Then opened up a gui ftp client
and music in amarok started to skip like for 2-3 seconds.

Btw Amarok uses Artsd ( KDE Sound Daemon ) which in turn set to use
Jack Alsa Backend.


Cheers,
ismail 


On Sat, 10 Jul 2004 10:50:44 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > * Redeeman <lkml@metanurb.dk> wrote:
> >
> > > this all seems pretty cool... do you think you could make a patch
> > > against mm for this? it would be greatly apreciated
> >
> > it should apply cleanly to 2.6.7-mm6. -mm7 already includes most of the
> > might_sleep() additions. I'll do a patch against -mm7 too.
> 
> here's the patch against -mm7:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.7-mm7-H3
> 
> the patch got really small because most of the fixes and infrastructure
> enhancements that resulted out of this patch are in -mm7 already. It
> will get even smaller later on.
> 
> 
> 
>         Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Time is what you make of it
