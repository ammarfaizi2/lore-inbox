Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271723AbTHDNJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271724AbTHDNJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:09:43 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:10739 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S271723AbTHDNJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:09:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Werner Almesberger <werner@almesberger.net>
Subject: Re: TOE brain dump
Date: Mon, 4 Aug 2003 08:08:50 -0500
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <g83n.8vu.9@gated-at.bofh.it> <20030803151000.D10280@almesberger.net> <3F2E1F7B.3020906@softhome.net>
In-Reply-To: <3F2E1F7B.3020906@softhome.net>
MIME-Version: 1.0
Message-Id: <03080408085000.03433@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 August 2003 03:55, Ihar 'Philips' Filipau wrote:
> Werner Almesberger wrote:
> > Ihar 'Philips' Filipau wrote:
> >>    Modern NPUs generally do this.
> >
> > Unfortunately, they don't - they run *some* code, but that
> > is rarely a Linux kernel, or a substantial part of it.
>
>    Embedded CPU we are using is based MIPS, and has a lot of specialized
> instructions.
>    It makes not that much sense to run kernel (especially Linux) on CPU
> which is optimized for handling of network packets. (And has actually
> several co-processors to help in this task).
>    How much sense it makes to run general purpose OS (optimized for PCs
> and servers) on devices which can make only couple of functions? (and no
> MMU btw)
>    It is a whole idea behind this kind of CPUs - to do a few of
> functions - but to do them good.
>
>    If you will start stretching CPUs like this to fit Linux kernel - it
> will generally just increase price. Probably there are some markets
> which can afford this.
>
>    Remeber - "Small is beatiful" (c) - and linux kernel far from it.
>    Our routing code which handles two GE interfaces (actually not pure
> GE, but up to 2.5GB) fits into 3k. 3k of code - and that's it. not 650kb
> of bzip compressed bloat. And it handles two interfaces, handles fast
> data path from siblign interfaces, handles up to 1E6 routes. 3k of code.
> not 650k of bzip.

And it handles ipfilter?
and LSM security hooks?
how about IPSec?
and IPv6?

I don't think so.
