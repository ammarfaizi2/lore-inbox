Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288090AbSAHPNV>; Tue, 8 Jan 2002 10:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288092AbSAHPNL>; Tue, 8 Jan 2002 10:13:11 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:59406 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S288090AbSAHPMz> convert rfc822-to-8bit; Tue, 8 Jan 2002 10:12:55 -0500
Date: Tue, 8 Jan 2002 11:59:36 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108030431.0099F38C58@perninha.conectiva.com.br>
Message-ID: <Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> Is it possible to decide, now what should go into 2.4.18 (maybe -pre3) -aa or 
> -rmap?

-rmap is 2.5 stuff. 

I would really like to integrate -aa stuff as soon as I can understand
_why_ Andrea is doing those changes.

Note that people will _always_ complain about VM: It will always be
possible to optimize it to some case and cause harm to other cases.

I'm not saying that VM is perfect right now: It for sure has problems.

> Andrew Morten`s read-latency.patch is a clear winner for me, too.

AFAIK Andrew's code simply adds schedule points around the kernel, right? 

If so, nope, I do not plan to integrate it.

> What about 00_nanosleep-5 and bootmem?

What is 00_nanosleep-5 and bootmem ? 

> The O(1) scheduler?

2.5 stuff.

> Maybe preemption? It is disengageable so nobody should be harmed but we get 
> the chance for wider testing.

2.5 too.


