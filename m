Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSKCEUS>; Sat, 2 Nov 2002 23:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSKCEUS>; Sat, 2 Nov 2002 23:20:18 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:9656 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S261600AbSKCEUR>; Sat, 2 Nov 2002 23:20:17 -0500
Date: Sat, 02 Nov 2002 22:26:13 -0500
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: Andrew Kanaber <akanaber@chiark.greenend.org.uk>
Subject: Re: [PATCH] Athlon cache-line fix
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021102230945.A5273@chiark.greenend.org.uk>
References: <20021102005122.2205.AKIRA-T@suna-asobi.com> <20021102230945.A5273@chiark.greenend.org.uk>
Message-Id: <20021102222313.37A8.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop018.verizon.net from [138.89.32.225] at Sat, 2 Nov 2002 22:26:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002 23:09:45 +0000
Andrew Kanaber <akanaber@chiark.greenend.org.uk> mentioned:
> Akira Tsukamoto wrote:
> > For Athlon CPU, CONFIG_X86_MK7,
> > the X86_L1_CACHE_SHIFT is set to 6, 128 Bytes
> 
> Eh? L1_CACHE_BYTES is defined as (1 << L1_CACHE_SHIFT) in
> include/asm-i386/cache.h, which makes for a cache line size of 64 bytes
> which is right. Perhaps you were assuming the cache line size was
> 2 << L1_CACHE_SHIFT ?

Yes, it is 32bytes. :)
I think I was not sleeping right.

> Interesting that it increases
> performance (on at least one benchmark) though.

I also tried many times and it increases performace.

-- 
Akira Tsukamoto <akira-t@suna-asobi.com, at541@columbia.edu>


