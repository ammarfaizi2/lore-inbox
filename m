Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264999AbSIWDLu>; Sun, 22 Sep 2002 23:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSIWDLu>; Sun, 22 Sep 2002 23:11:50 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:28294 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S264999AbSIWDLu>;
	Sun, 22 Sep 2002 23:11:50 -0400
Message-ID: <1032751018.3d8e87aa99cc2@kolivas.net>
Date: Mon, 23 Sep 2002 13:16:58 +1000
From: Con Kolivas <conman@kolivas.net>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] gcc3.2 v 2.95.3 (contest and linux-2.5.38)
References: <1032750261.3d8e84b5486a9@kolivas.net> <1032750631.966.1003.camel@phantasy>
In-Reply-To: <1032750631.966.1003.camel@phantasy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Robert Love <rml@tech9.net>:

> On Sun, 2002-09-22 at 23:04, Con Kolivas wrote:
> 
> > IO Full Load:
> > Kernel                  Time            CPU
> > 2.5.38                  170.21          42%
> > 2.5.38-gcc32            1405.25         8%
> 
> Ugh??  Something is _seriously_ messed up here.

Agreed!

> The CPU utilization is only 8% but the time is nearly 10x worse.  You
> sure the only difference was the compiler?  I could think gcc-3.2 makes
> some poorer choices wrt code optimization, but nothing feasible can come
> to mind that would produce such terrible results.

Absolutely certain. I'm shaking from the results still... hard to type...

> Also, I believe RedHat is compiling their kernel in 8.0 with gcc-3.2,
> unless they reintroduced kgcc.  Surely that are not seeing these abysmal
> numbers.

contest is a new benchmark. Noone has ever done anything like this before so it
wouldn't have shown up in ordinary benchmarks. Mandrake has done the same with
LM9.0 I believe

Con
