Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289219AbSA1P4B>; Mon, 28 Jan 2002 10:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289218AbSA1Pzw>; Mon, 28 Jan 2002 10:55:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9933 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289225AbSA1Pzk>;
	Mon, 28 Jan 2002 10:55:40 -0500
Date: Mon, 28 Jan 2002 18:53:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [sched] bitmap cleanup, speedup, 2.5.3-pre5
In-Reply-To: <200201281546.HAA02275@nell.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201281852300.11556-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jan 2002, H. Peter Anvin wrote:

> Should typically be:

> 	__asm__("bsfl %1,%0"
> 		:"=r" (word)
> 		:"rm" (word));

> There is no reason to force the compiler to put the operand in a
> register.

agreed.

	Ingo

