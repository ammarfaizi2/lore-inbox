Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130999AbQLLFrZ>; Tue, 12 Dec 2000 00:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131448AbQLLFrP>; Tue, 12 Dec 2000 00:47:15 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:21515 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S130999AbQLLFrF>; Tue, 12 Dec 2000 00:47:05 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Mike Galbraith <mikeg@wen-online.de>
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
Date: Mon, 11 Dec 2000 22:17:36 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.Linu.4.10.10012120529110.970-100000@mikeg.weiden.de>
In-Reply-To: <Pine.Linu.4.10.10012120529110.970-100000@mikeg.weiden.de>
MIME-Version: 1.0
Message-Id: <00121122173600.03488@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Mike Galbraith wrote:
> On Mon, 11 Dec 2000, Steven Cole wrote:
> > I have a SMP (dual P-III 733Mhz) machine at work, but it will be
> > unavailable for testing for a few more days.  I suspect that 2.4.0-test12
> > will do better than 2.2.18 with 2 CPUs.  I'll know in a few days.
[snip]
>
> I think it's better with -j.  Do it with -jN where N is small enough
> to keep the box away from swap, and then repeat with N large enough to
> swap modestly (not too heavily or you're only testing disk MTBF:).

I've always used make -j2 bzImage for my two processor machine. 
I like being able to build kernels in a little over two minutes. 

Simple question here, and risking displaying great ignorance:
Does it make sense to use make -jN where N is much greater than the 
number of CPUs?  

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
