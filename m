Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275486AbRIZS7M>; Wed, 26 Sep 2001 14:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275485AbRIZS7E>; Wed, 26 Sep 2001 14:59:04 -0400
Received: from bacon.van.m-l.org ([208.223.154.200]:33923 "EHLO
	bacon.van.m-l.org") by vger.kernel.org with ESMTP
	id <S275486AbRIZS64>; Wed, 26 Sep 2001 14:58:56 -0400
Date: Wed, 26 Sep 2001 14:59:23 -0400 (EDT)
From: George Greer <greerga@m-l.org>
X-X-Sender: <greerga@bacon.van.m-l.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <E15mIoy-0001Hd-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109261457580.1519-100000@bacon.van.m-l.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Alan Cox wrote:

>and for completeness
>
>VIA Cyrix CIII (original generation 0.18u)
>
>nothing: 28 cycles
>locked add: 29 cycles
>cpuid: 72 cycles
>
>Pentium Pro
>
>nothing: 33 cycles
>locked add: 51 cycles
>cpuid: 98 cycles
>
>(base comparison - pure in order machine)
>
>IDT winchip
>
>nothing: 17 cycles
>locked add: 20 cycles
>cpuid: 33 cycles

2x Pentium MMX 233MHz

nothing: 14 cycles
locked add: 59 cycles
cpuid: 31 cycles

2x Pentium 133MHz

nothing: 14 cycles
locked add: 76 cycles
cpuid: 31 cycles

cpuid is oddly fast.

-- 
George Greer, greerga@m-l.org | Genius may have its limitations, but stupidity
http://www.m-l.org/~greerga/  | is not thus handicapped. -- Elbert Hubbard

