Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbSJIXHH>; Wed, 9 Oct 2002 19:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262359AbSJIXHH>; Wed, 9 Oct 2002 19:07:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48908 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262358AbSJIXHG>; Wed, 9 Oct 2002 19:07:06 -0400
Date: Wed, 9 Oct 2002 16:14:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
In-Reply-To: <3DA4B1EC.781174A6@mvista.com>
Message-ID: <Pine.LNX.4.44.0210091613590.9234-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, george anzinger wrote:
> 
> This patch, in conjunction with the "core" high-res-timers
> patch implements high resolution timers on the i386
> platforms.

I really don't get the notion of partial ticks, and quite frankly, this 
isn't going into my tree until some major distribution kicks me in the 
head and explains to me why the hell we have partial ticks instead of just 
making the ticks shorter.

		Linus

