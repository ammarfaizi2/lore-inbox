Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbSIZOhS>; Thu, 26 Sep 2002 10:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261308AbSIZOhS>; Thu, 26 Sep 2002 10:37:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27804 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261306AbSIZOhQ>; Thu, 26 Sep 2002 10:37:16 -0400
Date: Thu, 26 Sep 2002 11:42:16 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Ingo Molnar <mingo@elte.hu>
Cc: Con Kolivas <conman@kolivas.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Useful fork info? WAS Re: [BENCHMARK] fork_load module tested
 for contest
In-Reply-To: <Pine.LNX.4.44.0209261023500.2944-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L.0209261141280.15154-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Ingo Molnar wrote:

> > fork_load:
> > Kernel                  Time            CPU             Ratio
> > 2.4.19                  97.11           67%             1.33
> > 2.4.19-ck7              72.34           92%             0.99
> > 2.5.38                  75.32           92%             1.03
> > 2.5.38-mm2              74.99           92%             1.03
>
> shouldnt the CPU load be 100% for such a test?

The total load, yes.  The CPU has one 'make -j4' on the kernel
source and one fork load.

What I don't understand is why the fork load only gets 8% of
the CPU, instead of the 20% that is its right...

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

