Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbTAQJFd>; Fri, 17 Jan 2003 04:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbTAQJFd>; Fri, 17 Jan 2003 04:05:33 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:35976 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP
	id <S267439AbTAQJF2>; Fri, 17 Jan 2003 04:05:28 -0500
Date: Fri, 17 Jan 2003 09:15:30 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein31.homenet>
To: Jonah Sherman <jsherman@stuy.edu>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Trivial: Fix date in i386 microcode changelog
In-Reply-To: <20030116155440.GA2471@rootbox>
Message-ID: <Pine.LNX.4.33.0301170914230.1110-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonah,

Yes, your patch is correct, thanks.

Regards
Tigran

On Thu, 16 Jan 2003, Jonah Sherman wrote:

> The changelog dates for the i386 microcode are wrong(1.11 is
> before 1.09 and 1.10)
> Patch is against 2.5.58
>
> diff -Nru linux-2.5.58/arch/i386/kernel/microcode.c linux-2.5.58-new/arch/i386/kernel/microcode.c
> --- linux-2.5.58/arch/i386/kernel/microcode.c	2003-01-14 00:58:25.000000000 -0500
> +++ linux-2.5.58-new/arch/i386/kernel/microcode.c	2003-01-16 10:38:55.000000000 -0500
> @@ -55,7 +55,7 @@
>   *		Tigran Aivazian <tigran@veritas.com>,
>   *		Serialize updates as required on HT processors due to speculative
>   *		nature of implementation.
> - *	1.11	22 Mar 2001 Tigran Aivazian <tigran@veritas.com>
> + *	1.11	22 Mar 2002 Tigran Aivazian <tigran@veritas.com>
>   *		Fix the panic when writing zero-length microcode chunk.
>   */
>
>

