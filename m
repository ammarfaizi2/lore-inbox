Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317221AbSEXRz2>; Fri, 24 May 2002 13:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317216AbSEXRz1>; Fri, 24 May 2002 13:55:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:18173 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317215AbSEXRz0>; Fri, 24 May 2002 13:55:26 -0400
Subject: Re: Compiling 2.2.19 with -O3 flag
From: Robert Love <rml@tech9.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcus Meissner <mm@ns.caldera.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020524184402.A24780@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 May 2002 10:55:20 -0700
Message-Id: <1022262920.956.258.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-24 at 10:44, Christoph Hellwig wrote:

> -Os implies -O2 + additional size-reducing features:
> 
> [hch@sb hch]$ grep -r optimize_size /work/people/hch/gcc/gcc | wc -l
>     250
> [hch@sb hch]$
> 
> A bunch of matches are in ChangeLog and most are target-specific,
> but I guess you got the point..

I know this...maybe I am not being clear.  I realize -Os is a derivate
of -O2, but is it not an interesting note if -Os can be as fast (or
faster) than -O2 and still generate smaller binaries?  That is my point.

If -Os is equivalent in speed to -O2 but also generates smaller objects,
then why have -O2?  If it does not generate smaller objects (which is
what my testing has shown) then it is worthless.  Unless it is faster
than -O2, like Alan said, in which case then the two options need to
rethink themselves ;-)

	Robert Love

