Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271588AbRHPQ3d>; Thu, 16 Aug 2001 12:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271590AbRHPQ3X>; Thu, 16 Aug 2001 12:29:23 -0400
Received: from [213.97.137.182] ([213.97.137.182]:44555 "HELO
	iceberg.activanet.net") by vger.kernel.org with SMTP
	id <S271588AbRHPQ3D>; Thu, 16 Aug 2001 12:29:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Eduardo =?iso-8859-1?q?Cort=E9s=20?= <the_beast@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: limit cpu
Date: Thu, 16 Aug 2001 18:29:15 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.10.10108161610150.19342-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10108161610150.19342-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010816162913Z271588-760+2494@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 August 2001 18:13, you wrote:
> > > > i want to know if linux can limit the max cpu usage (not cpu time)
> > > > per user,
> > >
> > > no.  doing so would inherently slow down the scheduler.
> >
> > but *BSD has this feature, what's the problem in linux?
>
> I said that, thinking that it would require another test along
> the scheduler's fast path.  but if we only test when a process
> has exhausted its quantum (or perhaps at counter-recalc),
> the overhead would be minor.

I think that it's a good feature for linux, but I don't know if is very 
complex to develope in linux. If I can limit the max cpu usage (in %) for an 
user/group, the box is more solid.
