Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318180AbSG3BmN>; Mon, 29 Jul 2002 21:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSG3BmN>; Mon, 29 Jul 2002 21:42:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28687 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318180AbSG3BmN>; Mon, 29 Jul 2002 21:42:13 -0400
Date: Mon, 29 Jul 2002 18:46:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spinlock.h cleanup
In-Reply-To: <1027989053.929.263.camel@sinai>
Message-ID: <Pine.LNX.4.44.0207291845470.945-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 29 Jul 2002, Robert Love wrote:
>
> I hope so, we only check for gcc < 2.0.

Check that again. The old check was for "(__GNUC__ > 2)", ie it would only
trigger for gcc-3 and up.

> If I recall correctly, the fix was for older egcs compilers.

I've got this memory of fairly recent gcc's messing up on sparc, for
example.

		Linus

