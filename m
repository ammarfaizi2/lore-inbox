Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268787AbRG0God>; Fri, 27 Jul 2001 02:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268789AbRG0Go0>; Fri, 27 Jul 2001 02:44:26 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:4480
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S268787AbRG0GoP>; Fri, 27 Jul 2001 02:44:15 -0400
Date: Thu, 26 Jul 2001 23:44:16 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200107270644.f6R6iGA08383@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1
In-Reply-To: <9jqm6n$163$1@penguin.transmeta.com>
In-Reply-To: <9C117960438@vcnet.vc.cvut.cz> <20010726175735.A20320@twiddle.net> <9jqm6n$163$1@penguin.transmeta.com>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In LKML, you wrote:

> I did some repmacement of "extern" into "static" in 2.4.8-pre1, but
> I don't have gcc-3.0.x on my machines (too many headaches, too
> little time).

For gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85), I had to
change the "static"s in include/linux/parport_pc.h back to "extern"s
to get drivers/parport/parport_pc.c to compile (as a module).

Cheers, Wayne

