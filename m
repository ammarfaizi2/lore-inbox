Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUFGXDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUFGXDD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbUFGXDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:03:03 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:24194 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S264256AbUFGXCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:02:52 -0400
Date: Mon, 7 Jun 2004 19:04:29 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: Hal Nine <hal9@cyberspace.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Flushing the swap
In-Reply-To: <200406072234.SAA07853@grex.cyberspace.org>
Message-ID: <Pine.LNX.4.58.0406071850140.5027@tiamat.perryconsulting.net>
References: <200406072234.SAA07853@grex.cyberspace.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not to be fecicious, you can reboot.

But if this is not good enough, you can try this:

swapoff -a
swapon -a

This may take a while if your system is busy and a lot of RAM has been used.
It especially will take a long time if your system was dipping into swap because an active process really needed that extra ram.

You can kill off as many memory hungry processes as possible first, to try and do this as painlessly as possible.

My thought is this: if she wants swap, give her swap! It beats a diamond ring.

____________Arthur Perry________________
| Your friendly neighborhood Linux guy |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Registered Pine user .. again..




On Mon, 7 Jun 2004, Hal Nine wrote:

> Is there any way of making linux flush out all pages out of swap
> space?  I want to have 0K of used swap space.
>
> h9
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
