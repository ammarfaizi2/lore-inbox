Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282790AbRK0EbH>; Mon, 26 Nov 2001 23:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282792AbRK0Ea6>; Mon, 26 Nov 2001 23:30:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8177
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282790AbRK0Eal>; Mon, 26 Nov 2001 23:30:41 -0500
Date: Mon, 26 Nov 2001 20:30:32 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
Message-ID: <20011126203032.C26219@mikef-linux.matchmail.com>
Mail-Followup-To: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva> <01112615070600.00943@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01112615070600.00943@manta>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 03:07:06PM -0200, vda wrote:
> On Saturday 24 November 2001 16:39, Marcelo Tosatti wrote:
> > Hi,
> >
> > So here it goes 2.4.16-pre1. Obviously the most important fix is the
> > iput() one, which probably fixes the filesystem corruption problem people
> > have been seeing.
> 
> This is quite annoying to have non-pre kernels with simple bugs like 
> recent loop device bug etc.
> 
> Maybe this can be prevented by adopting a rule that non-pre kernel is made
> from last pre/ac/... which was good enough by changing version # _only_,
> without even single buglet squashing?
> 
> This way we will not disappoint those people who download non-pres in hope
> they are more stable.
> 
> Just my 2 cents. 

Yep.

The oops fix was just for a driver, but who knows how much testing that
patch has received?

2.4.16 looks like it will be what 2.4.15 was intended to be.

Hopefully, future kernels that are under Marcello's control won't have the
need to release becasue the last releas was broken.

This may have been one of the smallest changes between the last -pre and
-final.

Let's hope $(test -z "`diff -u last-pre -final`") returns true for future
2.4 kernels.

MF
