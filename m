Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273349AbRI0P1g>; Thu, 27 Sep 2001 11:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273326AbRI0P1R>; Thu, 27 Sep 2001 11:27:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59666 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273349AbRI0P1E>; Thu, 27 Sep 2001 11:27:04 -0400
Date: Thu, 27 Sep 2001 08:27:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux 0.01 disk lockup
In-Reply-To: <Pine.LNX.3.96.1010927150812.28147B-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0109270826060.17030-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Mikulas Patocka wrote:
>
> Linux 0.01 has a bug in disk request sorting - when interrupt happens
> while sorting is active, the interrupt routine won't clear do_hd - thus
> the disk will stay locked up forever.

Ehh..

Mikulas, do you want to be the official maintainer for the 0.01.xxx
series?

Note that much of the maintenance work is probably just to reproduce and
make all the user-level etc infrastructure available..

		Linus

