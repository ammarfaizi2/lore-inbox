Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUDIXvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 19:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUDIXvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 19:51:10 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:35086 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261943AbUDIXvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 19:51:07 -0400
Date: Sat, 10 Apr 2004 09:50:40 +1000
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ALPHA] Fix unaligned stxncpy again
Message-ID: <20040409235040.GA14950@gondor.apana.org.au>
References: <20040409103244.GA1904@gondor.apana.org.au> <20040409233511.B727@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040409233511.B727@den.park.msu.ru>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2004 at 11:35:11PM +0400, Ivan Kokshaysky wrote:
> 
> Here is simpler equivalent of that and ev6 fix.

Thanks.  But is there any reason why we need to have code that
is different from glibc?
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
