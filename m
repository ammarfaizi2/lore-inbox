Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278785AbRJVM4B>; Mon, 22 Oct 2001 08:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278788AbRJVMzu>; Mon, 22 Oct 2001 08:55:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19721 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S278785AbRJVMzn>; Mon, 22 Oct 2001 08:55:43 -0400
Date: Mon, 22 Oct 2001 10:55:01 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <abusch@gmx.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [oops] 2.4.12+i kswapd invalid operand: 0000
In-Reply-To: <18207.1003754971@www8.gmx.net>
Message-ID: <Pine.LNX.4.33L.0110221053570.22127-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 abusch@gmx.net wrote:

> There seems to be a problem with KSWAPD, maybe with the latest vm changes ?
> Haven't seen oops for a long time. Uptime was only 17 hours.
>
> The kernel is 2.4.12 patched with the international crypto patch 2.4.3.1
> and the 1521 NVidia module is loaded.

Can you reproduce this bug without the NVIDIA driver or
without the crypto patch ?

> >>EIP; c012a17b <__free_pages_ok+1b/1e0>   <=====
> Trace; c0129901 <shrink_cache+1c1/300>
> Trace; c0129bbc <shrink_caches+5c/90>
> Trace; c0129c1c <try_to_free_pages+2c/60>
> Trace; c0129cd1 <kswapd_balance_pgdat+51/a0>
> Trace; c0129d46 <kswapd_balance+26/50>
> Trace; c0129e91 <kswapd+a1/c0>
> Trace; c0129df0 <kswapd+0/c0>

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

