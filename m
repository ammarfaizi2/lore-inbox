Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVGZNJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVGZNJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVGZNJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:09:50 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:1710 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261753AbVGZNJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:09:49 -0400
In-Reply-To: <42E5F139.70002@yahoo.com.au>
References: <42E5F139.70002@yahoo.com.au>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9AB335F0-28CD-4561-B447-DA09CF44F0AB@freescale.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Hugh Dickins" <hugh@veritas.com>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [patch 0/6] remove PageReserved
Date: Tue, 26 Jul 2005 08:09:40 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 26, 2005, at 3:15 AM, Nick Piggin wrote:

> Hi Andrew,
>
> If you're feeling like -mm is getting too stable, then you might
> consider giving these patches a spin? (unless anyone else raises
> an objection).
>
> Ben thought I should get moving with them soon.
>
> Not much change from last time. A bit of ppc64 input from Ben,
> and some rmap.c input from Hugh. Boots and runs on a few machines
> I have lying around here.
>
> The only remaining places that *test* PageReserved are swsusp, a
> trivial useage in drivers/char/agp/amd64-agp.c, and arch/ code.
>
> Most of the arch code is just reserved memory reporting, which
> isn't very interesting and could easily be removed. Some arch users
> are a bit more subtle, however they *should not* break, because all
> the places that set and clear PageReserved are basically intact.

What is the desired fix look like for arch users?

- kumar

