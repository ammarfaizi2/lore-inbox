Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270679AbRHJXGC>; Fri, 10 Aug 2001 19:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270680AbRHJXFk>; Fri, 10 Aug 2001 19:05:40 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:59655 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S270679AbRHJXFe>; Fri, 10 Aug 2001 19:05:34 -0400
Date: Sat, 11 Aug 2001 09:05:33 +1000
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
Message-ID: <20010811090533.A28210@gondor.apana.org.au>
In-Reply-To: <200108102159.f7ALxb908284@penguin.transmeta.com> <E15VL6x-0007Jm-00@gondolin.me.apana.org.au> <k2y9orcyod.fsf@zero.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k2y9orcyod.fsf@zero.aec.at>
User-Agent: Mutt/1.3.18i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 12:55:46AM +0200, Andi Kleen wrote:
> 
> A process in D state sleeps and the BKL is always automatically dropped
> when a process sleeps.

OK.  What about console_lock since reboot(2) insists on doing a printk?
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
