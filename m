Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135331AbRD1Pym>; Sat, 28 Apr 2001 11:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135416AbRD1Pyb>; Sat, 28 Apr 2001 11:54:31 -0400
Received: from chiara.elte.hu ([157.181.150.200]:53519 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135331AbRD1PyS>;
	Sat, 28 Apr 2001 11:54:18 -0400
Date: Sat, 28 Apr 2001 17:52:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Ville Herva <vherva@mail.niksula.cs.hut.fi>,
        Fabio Riccardi <fabio@chromium.com>, <linux-kernel@vger.kernel.org>
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Apr 2001, Andi Kleen wrote:

> You can also just use the cycle counter directly in most modern CPUs.
> It can be read with a single instruction. In fact modern glibc will do
> it for you when you use clock_gettime(CLOCK_PROCESS_CPUTIME_ID, ...)

well, it's not reliable while using things like APM, so i'd not recommend
to depend on it too much.

	Ingo


