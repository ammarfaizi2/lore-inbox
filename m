Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUGHLTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUGHLTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 07:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUGHLTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 07:19:04 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:1040 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264917AbUGHLS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 07:18:56 -0400
Date: Thu, 8 Jul 2004 21:18:29 +1000
To: Linus Torvalds <torvalds@osdl.org>
Cc: Miles Bader <miles@gnu.org>, "David S. Miller" <davem@redhat.com>,
       chrisw@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sds@epoch.ncsc.mil, jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040708111829.GA3449@gondor.apana.org.au>
References: <20040707122525.X1924@build.pdx.osdl.net> <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com> <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040523i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 10:22:32PM -0700, Linus Torvalds wrote:
>
> I'm sorry that you are such a K&R-C bigot that you don't like type 
> checking. But the kernel DOES like type checking, and the kernel is not 
> K&R C. The kernel uses strict ANSI, and in fact, is _more_ strict than 
> ANSI C is in many many ways.

Well it's your project so you get to set the coding style.

But it is ironic that you call people who use 0 in a pointer context
K&R-C bigots.  One of the principal reason why NULL exists at all
is in fact the lack of prototypes in K&R...
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
