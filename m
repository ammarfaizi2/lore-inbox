Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUFOJVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUFOJVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 05:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUFOJVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 05:21:52 -0400
Received: from holomorphy.com ([207.189.100.168]:18085 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265383AbUFOJVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 05:21:50 -0400
Date: Tue, 15 Jun 2004 02:12:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [3/12] remove irda usage of isa_virt_to_bus()
Message-ID: <20040615091219.GR1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jean Tourrilhes <jt@bougret.hpl.hp.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040615014344.GA17657@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615014344.GA17657@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 06:43:44PM -0700, Jean Tourrilhes wrote:
> 	Could you please send this directly to me. I hate scrubbing
> large patches from the mailing list archive.
> 	Note that before even thinking of pushing this patch in the
> kernel, we need to perform testing with the hardware on i386 and
> potentially on ARM. The author only tried with irtty that doesn't use
> this function, so that's not a valid test at all. Finding people test
> those changes is going to be tough, as usual.
> 	I'm also wondering about the validity of those changes, but
> that's another matter I need to go through. During 2.5.X, some people
> assured me that using isa_virt_to_bus was safe on all platform with an
> ISA bus...

Okay, well, I myself didn't produce this, and I couldn't tell offhand
if it was bogus or not. I presumed bugreporter made happy and spraying
it across the debian userbase was enough to verify it at runtime. From
what you're telling me, this is not the case.

Can you recommend people to do this kind of testing?

Apparently people aren't entirely happy with "dump it on lkml and wait
for an ack or nak", which I've noted for future reference, but probably
won't have a need to consider again (it's very rare that I have to deal
with changes I didn't write myself or are otherwise in areas I don't
have much knowledge about). OTOH, it was easier to find than buried in
a distro BTS and/or cvs, not that that makes it ideal.


-- wli
