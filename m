Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289007AbSAZDQL>; Fri, 25 Jan 2002 22:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289005AbSAZDPw>; Fri, 25 Jan 2002 22:15:52 -0500
Received: from zero.tech9.net ([209.61.188.187]:44812 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289003AbSAZDPb>;
	Fri, 25 Jan 2002 22:15:31 -0500
Subject: Re: [PATCH] syscall latency improvement #1
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>, torvalds@transmeta.com, ak@suse.de
In-Reply-To: <1012014412.3799.259.camel@phantasy>
In-Reply-To: <p73y9il7vlr.fsf@oldwotan.suse.de>
	<Pine.LNX.4.33.0201251741430.16917-100000@penguin.transmeta.com> 
	<3C521003.991A690B@zip.com.au>  <1012014412.3799.259.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 22:20:39 -0500
Message-Id: <1012015240.3505.267.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 22:06, Robert Love wrote:

> Same program, AMD Athlon MP 1600 (booted UP), kernel 2.5.3-pre5.
> 
> with cli:	real 0m19.706s	user 0m11.400s	sys 0m8.290s
> without cli:	real 0m19.449s  user 0m10.630s	sys 0m8.820s
> 
> That is 1.3% improvement.

And let me add with David Howell's patch:

patch:	real 0m19.305s	user 0m8.130s	sys 0m11.180s

Which is 0.7% faster than without cli, and 2.07% faster than the stock
(with cli) kernel.  This is the average of three runs, btw.

	Robert Love

