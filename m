Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289002AbSAZDCI>; Fri, 25 Jan 2002 22:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289000AbSAZDB6>; Fri, 25 Jan 2002 22:01:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:39436 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288998AbSAZDBs>;
	Fri, 25 Jan 2002 22:01:48 -0500
Subject: Re: [PATCH] syscall latency improvement #1
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <3C521003.991A690B@zip.com.au>
In-Reply-To: <p73y9il7vlr.fsf@oldwotan.suse.de>
	<Pine.LNX.4.33.0201251741430.16917-100000@penguin.transmeta.com> 
	<3C521003.991A690B@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 22:06:51 -0500
Message-Id: <1012014412.3799.259.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 21:10, Andrew Morton wrote:

> With cli:
> 	./a.out  22.05s user 15.31s system 99% cpu 37.361 total
> 
> without cli: 
> 	./a.out  18.29s user 17.42s system 99% cpu 35.731 total
> 
> 
> That's 4.6%.  Intel P3.

Same program, AMD Athlon MP 1600 (booted UP), kernel 2.5.3-pre5.

with cli:	real 0m19.706s	user 0m11.400s	sys 0m8.290s
without cli:	real 0m19.449s  user 0m10.630s	sys 0m8.820s

That is 1.3% improvement.

	Robert Love

