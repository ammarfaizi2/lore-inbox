Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbULQQGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbULQQGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbULQQGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:06:23 -0500
Received: from holomorphy.com ([207.189.100.168]:58837 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261416AbULQQGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:06:15 -0500
Date: Fri, 17 Dec 2004 08:05:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041217160552.GZ771@holomorphy.com>
References: <41BF1983.mailP9C1B91GB@suse.de.suse.lists.linux.kernel> <p73acsg1za1.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73acsg1za1.fsf@bragg.suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 07:59:50PM +0100, Andi Kleen wrote:
> I suspect xen64 will be rather different from xen32 anyways
> because as far as I can see the tricks Xen32 uses to be
> fast (segment limits) just plain don't work on 64bit
> because the segments don't extend into 64bit space.
> So having both in one architecture may also end up messy.
> And i386 and x86-64 are in many pieces very different anyways,
> I have my doubts that trying to mesh them together in arch/xen
> will be very pretty.

I have an inkling that the xen implementors may have plots of
additional architecture ports. If it really is x86/x86-64 -only it
isn't worth bothering with a separate arch/ dir, but it would be if it
were ported to a large number of architectures.

Maybe they're modelling it after UML which has its own arch/ dir but
then grabs assorted things from other architectures; in that event I
wouldn't consider it so misguided.

Probably best if the implementors chimed in about all this.


-- wli
