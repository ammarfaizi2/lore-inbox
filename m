Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314526AbSEBO7W>; Thu, 2 May 2002 10:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314545AbSEBO7V>; Thu, 2 May 2002 10:59:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56587 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314526AbSEBO7S>; Thu, 2 May 2002 10:59:18 -0400
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 2 May 2002 16:17:36 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CD13FF3.5020406@evision-ventures.com> from "Martin Dalecki" at May 02, 2002 03:32:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173IKu-00047S-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Modversions solves a huge number of problems very very well. The fact that
> > you don't like it doesn't change the reality of the situation.
> 
> Could you name *ONE* please? Maybe the following?

It handles the case when you have modules that don't get rebuilt as part of
the base kernel. It allows you to build fixed kernel images without spending
ages rebuilding all the modules when they otherwise match

> - As an added bonus it makes you use
> the force flag to insmod more often with binary only modules, which
> everybody loves... This gives you the good feeling of polite

Unrelated IMHO

> - And then we have no better use for our RAM then
> storing some extendid redundant string information there of course
> as well.

Which occupies almost no space

> Far better sollution then just versioning the kernel release

The kernel release isnt useful info. Many interfaces are stable across
multiple kernels, many interface issues depend on things other than kernel
version. Lots of people apply patches and don't change the base kernel
version - in fact its hard to do so

> Yes - versioning of every single piece is indeed a very good
> solution to the above problems and a nice piece of SW design!

I think so. It solves the first 95% of the problem. Solving 100% isnt easy
enough to be worth it. Throwing it out and solving 0% of the problem is
not very bright either
