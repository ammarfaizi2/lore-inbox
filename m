Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVAPUSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVAPUSw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVAPUSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:18:52 -0500
Received: from smtpout4.uol.com.br ([200.221.4.195]:4549 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S262574AbVAPUSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:18:50 -0500
Date: Sun, 16 Jan 2005 18:18:47 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Steve Snyder <swsnyder@insightbb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Testing optimize-for-size suitability?
Message-ID: <20050116201847.GC4009@ime.usp.br>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Steve Snyder <swsnyder@insightbb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200501161040.12907.swsnyder@insightbb.com> <1105890403.8734.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1105890403.8734.20.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 16 2005, Arjan van de Ven wrote:
> On Sun, 2005-01-16 at 10:40 -0500, Steve Snyder wrote:
> > Is there a benchmark or set of benchmarks that would allow me to test
> > the suitability of the CONFIG_CC_OPTIMIZE_FOR_SIZE kernel config
> > option?
> 
> it also saves 400 kb of memory that can be used by the pagecache now...
> that doesn't show in a microbenchmark but it's a quite sizable gain if
> you remember that a disk seek is 10msec..that is a LOT of cpu cycles..

Since I'm using a Duron 600MHz (the lowest model, AFAIK), I decided to
compile a new kernel with the -Os option. Despite the scary warning on the
help, it seems to be working fine for the first few moments with Debian's
testing gcc (3.3.5).

I haven't noticed any other improvement, but I guess that more memory
available to applications would never hurt (as long as stability is
preserved).

I will also try to compile other applications (like Firefox), since my main
memory is so limited and the small cache of my processor would surely
appreciate it.

Perhaps it is time to give the tiny-linux project a try to see what other
optimizations I can achieve.


Just another data point, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
