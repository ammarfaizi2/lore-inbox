Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288020AbSAMTIr>; Sun, 13 Jan 2002 14:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288021AbSAMTIi>; Sun, 13 Jan 2002 14:08:38 -0500
Received: from ns.ithnet.com ([217.64.64.10]:54280 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288020AbSAMTIZ>;
	Sun, 13 Jan 2002 14:08:25 -0500
Date: Sun, 13 Jan 2002 20:08:15 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David B. Stevens" <dsteven3@maine.rr.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -H7
Message-Id: <20020113200815.28b14e54.skraw@ithnet.com>
In-Reply-To: <3C41DA53.D91FE6E2@maine.rr.com>
In-Reply-To: <20020113185732.72ea3aa8.skraw@ithnet.com>
	<Pine.LNX.4.33.0201132056360.8784-100000@localhost.localdomain>
	<20020113194958.62f8f674.skraw@ithnet.com>
	<3C41DA53.D91FE6E2@maine.rr.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002 14:04:51 -0500
"David B. Stevens" <dsteven3@maine.rr.com> wrote:

> It works fine on top of 2.4.18-pre3 in UP config.

Sorry, I should have attached a short summary of my system:

dual PIII-1GHz / board Asus CUV4X-D (via chipset, no I did not encounter any
problems so far) / 2 GB RAM with highmem support on"Network" refers to tulip
quad-card in this case. It really hangs in _every_ boot at the same operation
(a ping).

Regards,
Stephan
 
> This e-maile is from such a system.
> 
> Cheers,
>   Dave
> 
> Stephan von Krawczynski wrote:
> > 
> > On Sun, 13 Jan 2002 20:58:12 +0100 (CET)
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > >
> > > On Sun, 13 Jan 2002, Stephan von Krawczynski wrote:
> > >
> > > > sched.o sched.c sched.c:21: asm/sched.h: No such file or directory
> > >
> > > Please re-download the 2.4.17 -H7 patch, i've fixed this.
> > 
> > Ok, I tried on top of vanilla 2.4.17 and it works.
> > 
> > Seems like 2.4.18-pre3 and H7 don't like each other :-)
> > 
> > Regards,
> > Stephan
