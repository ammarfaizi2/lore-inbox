Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277703AbRKACyb>; Wed, 31 Oct 2001 21:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277708AbRKACyL>; Wed, 31 Oct 2001 21:54:11 -0500
Received: from c1419467-a.sttln1.wa.home.com ([65.4.225.76]:47488 "EHLO
	zarathustra.saavie.org") by vger.kernel.org with ESMTP
	id <S277703AbRKACx7>; Wed, 31 Oct 2001 21:53:59 -0500
Date: Wed, 31 Oct 2001 18:53:59 -0800
From: Neil Spring <nspring@saavie.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP ECN bits and TCP_RESERVED_BITS macro
Message-ID: <20011031185358.A997@cs.washington.edu>
In-Reply-To: <20011031152717.A25584@morinfr.org> <20011031154305.A11081@cs.washington.edu> <20011101033221.A627@morinfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011101033221.A627@morinfr.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dans un message du 31 oct ? 15:43, Neil Spring ?crivait :
> > The line in your patch:
> > > -#define TCP_HP_BITS (~(TCP_RESERVED_BITS|TCP_FLAG_PSH)|TCP_FLAG_ECE|TCP_FLAG_CWR)
> > > +#define TCP_HP_BITS (~(TCP_RESERVED_BITS|TCP_FLAG_PSH))
> >
> > is, I believe, a very bad idea.  This preprocessor constant
>
> Well it is not. 

You're absolutely right.  And it is more clean, even if
it confused me at first.  Thanks for the explanation.

-neil
nethack told me to be careful, full moon tonight, but I
didn't listen.


