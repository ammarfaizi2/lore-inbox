Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbTFWAwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 20:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbTFWAwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 20:52:15 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:5292 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S264683AbTFWAwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 20:52:14 -0400
Date: Sun, 22 Jun 2003 18:05:55 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Daniel Phillips <phillips@arcor.de>, acme@conectiva.com.br, cw@f00f.org,
       torvalds@transmeta.com, geert@linux-m68k.org, alan@lxorguk.ukuu.org.uk,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Message-ID: <20030623010555.GA4302@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@digeo.com>, Daniel Phillips <phillips@arcor.de>,
	acme@conectiva.com.br, cw@f00f.org, torvalds@transmeta.com,
	geert@linux-m68k.org, alan@lxorguk.ukuu.org.uk, perex@suse.cz,
	linux-kernel@vger.kernel.org
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <20030622014345.GD10801@conectiva.com.br> <20030621191705.3c1dbb16.akpm@digeo.com> <200306221522.29653.phillips@arcor.de> <20030622103251.158691c3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030622103251.158691c3.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you think 3.[23] are slow, go back and compile with 2.7.2 - it's much 
faster than the later versions.  I used to yank newer versions of gcc 
off systems and put 2.7.2 on, I think it was close to 2x faster at 
compilation and made no difference on BK performance.

On Sun, Jun 22, 2003 at 10:32:51AM -0700, Andrew Morton wrote:
> Daniel Phillips <phillips@arcor.de> wrote:
> >
> > As for compilation speed, yes, that sucks.  I doubt there's any rational 
> >  reason for it, but I also agree with the idea that correctness and binary 
> >  code performance should come first, then the compilation speed issue should 
> >  be addressed.
> 
> No.  Compilation inefficiency directly harms programmer efficiency and the
> quality and volume of code the programmer produces.  These are surely the
> most important things by which a toolchain's usefulness should be judged.
> 
> I compile with -O1 all the time and couldn't care the teeniest little bit
> about the performance of the generated code - it just doesn't matter.
> 
> I'm happy allowing those thousands of people who do not compile kernels all
> the time to shake out any 3.2/3.3 compilation problems.
> 
> 
> Compilation inefficiency is the most serious thing wrong with gcc.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
