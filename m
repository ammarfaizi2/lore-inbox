Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261695AbSIXPea>; Tue, 24 Sep 2002 11:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSIXPea>; Tue, 24 Sep 2002 11:34:30 -0400
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:16321 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S261695AbSIXPea>; Tue, 24 Sep 2002 11:34:30 -0400
Date: Tue, 24 Sep 2002 11:47:30 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
In-Reply-To: <200209240850.g8O8odp24965@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0209241144550.28934-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (And if there's more than a 1% variation between same kernel, compiled
> > with different compilers then the test is bust.  Kernel CPU time is
> > dominated by cache misses and runtime is dominated by IO wait.
> > Quality of code generation is of tiny significance)
> 
> Well, not exactly. If it is true that Intel/MS compilers beat GCC
> by 30% on code size, 30% smaller kernel ought to make some difference.

if you think that's true, then have you tried a modern GCC with -Os?

afaikt, this comparison of gcc's is primarily interesting because it might
show up some either misoptimizations or perhaps semantic problems in the 
kernel (ie, perhaps violations of strict aliasing).

