Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287869AbSAMANk>; Sat, 12 Jan 2002 19:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287871AbSAMAN3>; Sat, 12 Jan 2002 19:13:29 -0500
Received: from zero.tech9.net ([209.61.188.187]:2833 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287869AbSAMANU>;
	Sat, 12 Jan 2002 19:13:20 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rob Landley <landley@trommello.org>, yodaiken@fsmlabs.com, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PTOO-0002tO-00@the-village.bc.nu>
In-Reply-To: <E16PTOO-0002tO-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 12 Jan 2002 19:16:03 -0500
Message-Id: <1010880963.3619.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-12 at 14:00, Alan Cox wrote:

> I see absolutely _no_ evidence to support this repeated claim. I'm still
> waiting to see any evidence that low latency patches are not sufficient, or
> an explanation of who is going to fix all the drivers you break in subtle
> ways

I'll work on fixing things the patch breaks.  I don't think it will be
that bad.  I've been working on preemption for a long long time, and
before me others have been working for a long long time, and I just
don't see the hordes of broken drivers or the tons of race-conditions
due to per-CPU data.  I have seen some, and I have fixed them.

For a solution to latency concerns, I'd much prefer to lay a framework
down that provides a proper solution and then work on fine tuning the
kernel to get the desired latency out of it.

	Robert Love

