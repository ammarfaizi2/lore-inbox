Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316693AbSE3PQ2>; Thu, 30 May 2002 11:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316690AbSE3PQ1>; Thu, 30 May 2002 11:16:27 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:26847 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316686AbSE3PQ0>;
	Thu, 30 May 2002 11:16:26 -0400
Date: Fri, 31 May 2002 01:16:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Zealey <mark@zealos.org>
Cc: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] generic copy_siginfo_to_user cleanup
Message-Id: <20020531011606.21e970f6.sfr@canb.auug.org.au>
In-Reply-To: <20020530150010.GA6139@itsolve.co.uk>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, 30 May 2002 16:00:10 +0100 Mark Zealey <mark@zealos.org> wrote:
>
> On Thu, May 30, 2002 at 03:47:54PM +1000, Stephen Rothwell wrote:
> 
> > +	switch (from->si_code && __SI_MASK) {
> 
> shouldnt this just be a single bitwise AND (i.e. from->si_code & __SI_MASK) ?

Absolutely ... thanks
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
