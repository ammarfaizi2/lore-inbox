Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbTBKRAx>; Tue, 11 Feb 2003 12:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267802AbTBKRAx>; Tue, 11 Feb 2003 12:00:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64012 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267732AbTBKRAv>; Tue, 11 Feb 2003 12:00:51 -0500
Date: Tue, 11 Feb 2003 09:06:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.60
In-Reply-To: <20030211162332.B24592@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302110906100.13587-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Feb 2003, Russell King wrote:
> 
> Generalising the signal handling might have made sense, but this amount
> of duplication _just_ to be able to handle non-hardware breakpoints is
> getting rather rediculous.

Oh wow. Yeah, this needs to be fixed some way, by teaching the regular 
signal handling about it.

> I will be looking into the possibility of carving up the generic
> signal handling into a saner structure so we don't have this mess.

Good.

		Linus

