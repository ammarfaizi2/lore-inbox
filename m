Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264973AbRGAEhK>; Sun, 1 Jul 2001 00:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbRGAEhB>; Sun, 1 Jul 2001 00:37:01 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:27402 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264971AbRGAEgw>; Sun, 1 Jul 2001 00:36:52 -0400
Date: Sat, 30 Jun 2001 21:35:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Removal of PG_marker scheme from 2.4.6-pre
In-Reply-To: <Pine.LNX.4.21.0106301628570.3394-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106302134050.1092-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Jun 2001, Marcelo Tosatti wrote:
>
> In pre7:
>
> "me: undo page_launder() LRU changes, they have nasty side effects"
>
> Can you be more verbose about this ?

See the thread about 2.4.5-ac13+ (and my pre3+) basically becoming
unusable for longish times (temporarily locking up) on linux-kernel. It
was due to these changes.

		Linus

