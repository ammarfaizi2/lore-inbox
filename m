Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288548AbSANBQu>; Sun, 13 Jan 2002 20:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288553AbSANBQk>; Sun, 13 Jan 2002 20:16:40 -0500
Received: from zero.tech9.net ([209.61.188.187]:47378 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288548AbSANBQ2>;
	Sun, 13 Jan 2002 20:16:28 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: yodaiken@fsmlabs.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kenneth Johansson <ken@canit.se>, arjan@fenrus.demon.nl,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3C42293F.4962EC82@linux-m68k.org>
In-Reply-To: <E16Pmok-0007GD-00@the-village.bc.nu>
	<3C41ED4E.4D3F2D2C@linux-m68k.org> <20020113171006.A17958@hq.fsmlabs.com> 
	<3C42293F.4962EC82@linux-m68k.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 20:19:21 -0500
Message-Id: <1010971163.1528.32.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-13 at 19:41, Roman Zippel wrote:

> > That is exactly what Andrew Morton disputes. So why do you think he is
> > wrong?

Victor is saying that Andrew contends the hard parts of his low-latency
patch are just as hard to maintain with a preemptive kernel.  This is
true, for the places where spinlocks are held anyway, but it assumes we
continue to treat lock breaking and explicit scheduling as our only
solution.  It isn't under a preemptible kernel.

	Robert Love

