Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSEZAof>; Sat, 25 May 2002 20:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSEZAoe>; Sat, 25 May 2002 20:44:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58891 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315487AbSEZAod>; Sat, 25 May 2002 20:44:33 -0400
Date: Sat, 25 May 2002 17:44:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pierre Cloutier <pcloutier@poseidoncontrols.com>
cc: Robert Schwebel <robert@schwebel.de>, <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <02052520342600.03849@TheBox>
Message-ID: <Pine.LNX.4.44.0205251739380.4355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Pierre Cloutier wrote:
>
> Linus misses the most important feature of hard real time in user space.
>
> [ Short answer: debuggability ]

I didn't miss it, but it hasn't come up, and I don't think it's actually
all that much an issue of "RTLinux vs RTAI", but simply an issue of "do
you have the same API in user land as in a module"?

Because if you have the same API, you can do non-RT development in user
land, and then just move it over once you know the basic code "works".

Since the API is bound to be fairly limited, that shouldn't be much of a
problem, but I have no idea what the actual development environments
offer, and I have ansolutely zero interest in trying on the RT
"straighjacket" myself ;)

			Linus

