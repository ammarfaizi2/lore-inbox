Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSGaIa2>; Wed, 31 Jul 2002 04:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317856AbSGaIa1>; Wed, 31 Jul 2002 04:30:27 -0400
Received: from cibs9.sns.it ([192.167.206.29]:54799 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S317854AbSGaIa0>;
	Wed, 31 Jul 2002 04:30:26 -0400
Date: Wed, 31 Jul 2002 10:33:40 +0200 (CEST)
From: venom@sns.it
To: Shanti Katta <katta@csee.wvu.edu>
cc: sparclinux@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: what version of gcc can be used to build kernels on Linux/sparc64?
In-Reply-To: <1028059341.17195.4.camel@indus>
Message-ID: <Pine.LNX.4.43.0207311031030.12627-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jul 2002, Shanti Katta wrote:

> Date: 30 Jul 2002 16:02:20 -0400
> From: Shanti Katta <katta@csee.wvu.edu>
> To: sparclinux@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Subject: what version of gcc can be used to build kernels on
>     Linux/sparc64?
>
> I would like to know what version of gcc is currently available to build
> linux kernels on Linux/Sparc64.
old egcs patched to compile at 64 bit or gcc 3.1 -m64

> I would like the builds to generate
> 64-bit executables.
This is different fron kernel, you need to compile a 64 bit glibc (use
2.2.5 sources), and so on for all shared libraries you need, then you can
compile a 64 bit executable.
I just should add it will be slower than a 32 bit executable  and a little
bigger, so if you are not sure you need 64 bit because you binary will use
more than 3.6 GB RAM itself, you do not need a 64 bit executable.

Luigi
>
> -Shanti
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

