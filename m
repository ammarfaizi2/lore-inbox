Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbRFTWzd>; Wed, 20 Jun 2001 18:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbRFTWzV>; Wed, 20 Jun 2001 18:55:21 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:48006 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S262915AbRFTWzK>; Wed, 20 Jun 2001 18:55:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Mike Harrold <mharrold@cas.org>
Subject: Re: [OT] Threads, inelegance, and Java
Date: Wed, 20 Jun 2001 13:53:59 -0400
X-Mailer: KMail [version 1.2]
Cc: landley@webofficenow.com, linux-kernel@vger.kernel.org
In-Reply-To: <200106201927.PAA01484@mah21awu.cas.org> <3B30FF33.58807C3F@evision-ventures.com>
In-Reply-To: <3B30FF33.58807C3F@evision-ventures.com>
MIME-Version: 1.0
Message-Id: <01062013535909.00776@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 15:53, Martin Dalecki wrote:
> Mike Harrold wrote:
>
> Well the transmeta cpu isn't cheap actually.

Any processor's cheap once it's got enough volume.  That's an effect not a 
cause.

> And if you talk about
> super computing, hmm what about some PowerPC CPU variant - they very
> compettetiv in terms of cost and FPU performance! Transmeta isn't the
> adequate choice here.

You honestly think you can fit 142 PowerPC processors in a single 1U, air 
cooled?

Liquid air cooled, maybe...

> Well both of those concepts fail in terms of optimization due
> to the same reason: much less information is present about
> the structure of the code then during source code compilation.

LESS info?

Anybody wanna explain to me how it's possible to do branch prediction and 
speculative execution at compile time?  (Ala iTanium?)  I've heard a few 
attempts at an explanation, but nothing by anybody who was sober at the 
time...

You have less time to work, but you actually have MORE info about how it's 
actually running...

> Additionaly there may be some performance wins due to the
> ability of runtime profiling (anykind thereof), however it still remains
> to be shown that this performs better then statically analyzed code.

Okay, I'll bite.  Why couldn't a recompiler (like MetroWerks stuff) do the 
same static analysis on large code runs that GCC or some such could do if you 
give it -Oinsane and let it think for five minutes about each file?

Obviously the run-time version isn't going to spend the TIME to do that.  But 
claiming the information to perform these actions isn't available just 
because your variables no longer have english names...

> > /Mike - who doesn't work for Transmeta, in case anyone was wondering...
> > :-)
>
> /Marcin - who doesn't bet a penny on Transmeta

/Rob, who still owns stock in Intel of all things.

Rob
