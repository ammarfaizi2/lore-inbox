Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314657AbSD1BqG>; Sat, 27 Apr 2002 21:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314658AbSD1BqF>; Sat, 27 Apr 2002 21:46:05 -0400
Received: from ip68-6-153-107.sd.sd.cox.net ([68.6.153.107]:36430 "EHLO
	train.sweet-haven.com") by vger.kernel.org with ESMTP
	id <S314657AbSD1BqE>; Sat, 27 Apr 2002 21:46:04 -0400
Date: Sat, 27 Apr 2002 18:45:42 -0700 (PDT)
From: Lew Wolfgang <wolfgang@sweet-haven.com>
To: Bob Tanner <tanner@real-time.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Dual (2) AMD ATHLON MP 1900+ CPUs gives APIC error on
 CPU[0]: 00(02)
In-Reply-To: <20020426213315.K25965@real-time.com>
Message-ID: <Pine.LNX.4.33.0204271835390.32014-100000@train.sweet-haven.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bob,

I had the same problem with a Tyan S2466N, except that
the system didn't crash.  It would intermittently
throw off these non-fatal APIC errors.  Using 2.4.18 I
was able to trigger an error storm just by running an
fft benchmark.

The problem seems to have been fixed by upgrading the
ROM BIOS to the most recent (beta) version.

Regards,
Lew Wolfgang

On Fri, 26 Apr 2002, Bob Tanner wrote:

> [1.] One line summary of the problem:
> Dual (2) AMD ATHLON MP 1900+ CPUs gives APIC error on CPU[0]: 00(02)
>
> [2.] Full description of the problem/report:
>
> Dual (2) AMD ATHLON MP 1900+ CPUs
> ASUA7M266D Motherboard
> 2 sticks of  Corsair CM72SD512R-2100 (1Gb RAM)
>
> When booting SMP-Kernels version 2.4.7, 2.4.9, 2.4.18 the box hangs with the
> following error:
>
> APIC error on CPU1: 00(02)
> APIC error on CPU0: 00(02)
>

<snip>

