Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbRFQTfS>; Sun, 17 Jun 2001 15:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbRFQTfI>; Sun, 17 Jun 2001 15:35:08 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:14600
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S262686AbRFQTez>; Sun, 17 Jun 2001 15:34:55 -0400
Date: Sun, 17 Jun 2001 12:33:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 VM & swap question
Message-ID: <20010617123326.G11642@opus.bloom.county>
In-Reply-To: <20010617104836.B11642@opus.bloom.county> <20010617221239.B1027@spiral.extreme.ro> <20010617122033.F11642@opus.bloom.county> <20010617223147.A5849@spiral.extreme.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010617223147.A5849@spiral.extreme.ro>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001 at 10:31:47PM +0300, Dan Podeanu wrote:
> > Yes, I know there's no hard and fast rule for the exact ammount of ram/swap one
> > needs that will always work.  However, in 2.2 for a 'workstation' one could
> > usually quite happily get away with having 128:128 and never have much of a
> > problem.  with 2.4.0 and up this isn't the case.  This has been the cause
> > of many people complaining quite loudly about 2.4 VM sucking and having
> > lots of OOM kills going about.  It's also been called an 'aritificial limit'
> > since one of the VM people had a patch to 'fix' this.  What I'm trying to
> > figure out is if this problem exists linearly or just with 'lower' ammounts
> > of total physical ram.  ie if I jump up to 512mb and don't have a webserver
> > or database (ie I've got 512mb so I end up with a big disk cache) will I need
> > to have 1gb of swap just to keep the VM happy?  Will 256 be enough?  Could I
> > even live w/o swap?
> 
> Probably you'd live with 512MB of swap.

Seeing as 256:256 seems to be doing fine on my other two machines, yes, it
might.  But since I'd repartition too (I hate swapfiles) I'd like to do it
once and be done with it.  I'd also like to know what exactly causes the
original problem (Like I said, my workload hasn't changed nor my programs
that much.  And w/ twice my swap I get the same swap usage I used to get
in 2.2/late 2.3..)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
