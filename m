Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbREaSR7>; Thu, 31 May 2001 14:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263141AbREaSRt>; Thu, 31 May 2001 14:17:49 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:7815 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S263139AbREaSRf>;
	Thu, 31 May 2001 14:17:35 -0400
Date: Thu, 31 May 2001 14:17:28 -0400
From: Mark Frazer <mark@somanetworks.com>
To: Pete Wyckoff <pw@osc.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Makefile patch for cscope and saner Ctags
Message-ID: <20010531141728.C28505@somanetworks.com>
Mail-Followup-To: Pete Wyckoff <pw@osc.edu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010530180232.A4546@somanetworks.com> <20010531134530.A15302@osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010531134530.A15302@osc.edu>; from pw@osc.edu on Thu, May 31, 2001 at 01:45:30PM -0400
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Wyckoff <pw@osc.edu> [01/05/31 13:56]:
> 
> You seem not to have read my response to your earlier mail proprosing
> such a thing (for tags only, not cscope):
> 
>     http://boudicca.tux.org/hypermail/linux-kernel/2001week21/1869.html

I did.  I didn't want to sign up to maintain the ctags-ignore file though.

> 
> How does the patch above fix anything?  You're sorting so that
> include/linux/*.h comes before include/linux/{mtd,lockd,raid,...}/*.h,
> but I don't see how that can be an improvement, or how it addresses
> your original complaint "ctags doesn't honour any CPP #if'ing".

The sort -s is a stable sort, so by putting things into ctags in the
order I want them to appear in my tags file I get what I want.  YMMV

My original complaint ain't gonna get fixed anytime soon.

Your script is definitely a better solution IMO.

-mark
