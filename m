Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263002AbSJGMW0>; Mon, 7 Oct 2002 08:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263005AbSJGMW0>; Mon, 7 Oct 2002 08:22:26 -0400
Received: from zero.aec.at ([193.170.194.10]:53010 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S263002AbSJGMWZ>;
	Mon, 7 Oct 2002 08:22:25 -0400
Date: Mon, 7 Oct 2002 14:27:44 +0200
From: Andi Kleen <ak@muc.de>
To: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
       jakub@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
Message-ID: <20021007122744.GA24820@averell>
References: <20020929152731.GA10631@averell> <20020929160113.K5659@devserv.devel.redhat.com> <20021007030541.A3910@twiddle.net> <20021007.032900.51704978.davem@redhat.com> <20021007105622.GA24530@averell> <20021007044506.D3910@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007044506.D3910@twiddle.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 01:45:06PM +0200, Richard Henderson wrote:
> On Mon, Oct 07, 2002 at 12:56:22PM +0200, Andi Kleen wrote:
> > I retested it on gcc 3.2 and it unfortunately doesn't make any difference
> > (resulting kernel is byte-for-byte identical). So it looks like with
> > current gcc it isn't worth the effort.
> 
> *shrug* It's still good documentation of intent.  And one of
> these days we might get around to writing some aliasing code
> that doesn't suck quite so much.  ;-)

I'll resubmit the patch then.

Thanks for the feedback.

-Andi
