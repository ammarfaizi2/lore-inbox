Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278335AbRJMReK>; Sat, 13 Oct 2001 13:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277970AbRJMReB>; Sat, 13 Oct 2001 13:34:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29707 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277974AbRJMRdw>; Sat, 13 Oct 2001 13:33:52 -0400
Date: Sat, 13 Oct 2001 10:34:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pentium IV cacheline size.
In-Reply-To: <20011013125733.A10917@suse.de>
Message-ID: <Pine.LNX.4.33.0110131033300.8707-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Oct 2001, Dave Jones wrote:
>
> Currently, we're using a L1_CACHE_SHIFT value of 7
> for Pentium 4, which equates to 128 byte cache lines.

Well, the fact is, that from a SMP standpoint, the 128 bytes is the
correct one: the L2 is 128 bytes wide.

		Linus

