Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271609AbRHPS2i>; Thu, 16 Aug 2001 14:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271608AbRHPS22>; Thu, 16 Aug 2001 14:28:28 -0400
Received: from [213.97.137.182] ([213.97.137.182]:59148 "HELO
	iceberg.activanet.net") by vger.kernel.org with SMTP
	id <S271606AbRHPS2P>; Thu, 16 Aug 2001 14:28:15 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Eduardo =?iso-8859-1?q?Cort=E9s=20?= <the_beast@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: limit cpu
Date: Thu, 16 Aug 2001 20:28:27 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.10.10108161610150.19342-100000@coffee.psychology.mcmaster.ca> <20010816162913Z271588-760+2494@vger.kernel.org> <0b7201c1267c$5c30b260$103147ab@cisco.com>
In-Reply-To: <0b7201c1267c$5c30b260$103147ab@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010816182820Z271606-760+2516@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If somebody want to develope it, a lot of thanks. I see scheduler could be 
better with this feature, opinions?

On Thursday 16 August 2001 19:53, Hua Zhong wrote:
> Current Linux scheduler doesn't seem to be able to support this nicely. 
> You can set their priorities..but the values are not very intuitive.  And
> if you sleep, the result could become very inaccurate.
>
> A new scheduler (sth like weighted round robin) is a more natural solution.
> You just assign weights to processes and they will be scheduled
> accordingly.
>
> ----- Original Message -----
> From: "Eduardo Cortés" <the_beast@softhome.net>
> To: <linux-kernel@vger.kernel.org>
> Sent: Thursday, August 16, 2001 9:29 AM
> Subject: Re: Re: limit cpu
>
> > On Thursday 16 August 2001 18:13, you wrote:
> > > > > > i want to know if linux can limit the max cpu usage (not cpu
> > > > > > time) per user,
> > > > >
> > > > > no.  doing so would inherently slow down the scheduler.
> > > >
> > > > but *BSD has this feature, what's the problem in linux?
> > >
> > > I said that, thinking that it would require another test along
> > > the scheduler's fast path.  but if we only test when a process
> > > has exhausted its quantum (or perhaps at counter-recalc),
> > > the overhead would be minor.
> >
> > I think that it's a good feature for linux, but I don't know if is very
> > complex to develope in linux. If I can limit the max cpu usage (in %) for
>
> an
>
> > user/group, the box is more solid.
