Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUBYPIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUBYPIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:08:20 -0500
Received: from zadnik.org ([194.12.244.90]:20950 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S261350AbUBYPIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:08:18 -0500
Date: Wed, 25 Feb 2004 17:08:03 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Rik van Riel <riel@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <Pine.LNX.4.53.0402250813120.7525@chaos>
Message-ID: <Pine.LNX.4.44.0402251647190.17570-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But the idea that the kernel should exist as a kind of onion,
> depicted by child college professors in their children's coloring
> books is wrong. The optimum operating system will always be the
> one that performs its functions in the most expedient way, not
> the one that is the "prettiest" or easiest to understand. There
> can't be any such thing as a "layering violation".

Hm.

I won't agree. In my 25 years of programming, I am yet to see a case whe
ugly, "write-only" code performed well. And the cases when "pretty"
code has performed badly were rather rare.

Isolation and layering have already proved themselves a lot. If not so,
Unix would be dead, and we would be using now Multics or another similar
OS. Also, Windows would be immesurably superior to any Unix in existence,
especially in performance...

> Layering is wrong. However modularizing, although it may
> have some negative effects, has many redeeming values. It
> allows for the removal of dead code, code that will never
> function in a particular system.

I won't agree here, too. Dead code can be removed perfectly well from a
big kernel, too - maybe even easier. With a modular approach, you may
exclude certain module from your modules list, but I won't call that
removal of dead code.

Also, (logical) layering and modularizing do not contradict - they are
practically independent. I apologize for not being able to see the point
here.



