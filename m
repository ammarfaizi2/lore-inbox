Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270405AbRHSPdg>; Sun, 19 Aug 2001 11:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270418AbRHSPd0>; Sun, 19 Aug 2001 11:33:26 -0400
Received: from ool-182d17f9.dyn.optonline.net ([24.45.23.249]:57608 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S270405AbRHSPdI>;
	Sun, 19 Aug 2001 11:33:08 -0400
Date: Sun, 19 Aug 2001 11:33:19 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <20010819111357.A3504@thunk.org>
Message-ID: <Pine.LNX.4.33.0108191130020.14222-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 19 Aug 2001, Theodore Tso wrote:

> The bottom line is it really depends on how paranoid you want to be,
> and how much and how closely you want /dev/random to reliably replace
> a true hardware random number generator which relies on some physical
> process (by measuring quantum noise using a noise diode, or by
> measuring radioactive decay).  For most purposes, and against most
> adversaries, it's probably acceptable to depend on network interrupts,
> even if the entropy estimator may be overestimating things.

Not picking on you Ted, but in the end, people have to remember this
is a configurable option.  If you don't want it, don't enable it.  In
fact, I believe it's set to be off by default, so just have a
Configure.help entry that says "Don't enable unless you really know what
you're doing."

-Rob Radez

