Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288286AbSACSre>; Thu, 3 Jan 2002 13:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288284AbSACSrO>; Thu, 3 Jan 2002 13:47:14 -0500
Received: from ns.suse.de ([213.95.15.193]:10767 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288285AbSACSqx>;
	Thu, 3 Jan 2002 13:46:53 -0500
Date: Thu, 3 Jan 2002 19:46:28 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Uros Bizjak <uros@kss-loka.si>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, <petkan@dce.bg>
Subject: Re: 2.5.1-dj10, 486 string copies
In-Reply-To: <Pine.LNX.4.05.10201031141560.6476-100000@pulsar.kss-loka.si>
Message-ID: <Pine.LNX.4.33.0201031944480.12592-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Uros Bizjak wrote:

>   There is still patch to string-486.h at http://www.dce.bg/~petkan/
> waiting for inclusion in 2.4 kernel.
>
>   This patch was written by Petko Manolov (petkan@dce.bg) and can be found
> at http://www.dce.bg/~petkan/linux/string-486.diff
>
>   Intro to patch says:
>
>   Patch to .../linux-2.4.0-test7/include/asm-i386/string-486.h. memset and
> memcpy routines was completely rewritten in order to get higher
> performance. The aim is to go in final 2.4 kernels so please test.

If they've been tested, and shown to be faster (and more importantly,
they work correctly), I've no problem including this.

It could still use some work though. 3dnow!/mmx copies in a file
called string-486.h is a bit.. odd.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

