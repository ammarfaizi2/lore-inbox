Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUGPR02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUGPR02 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266609AbUGPR02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:26:28 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:31947 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263585AbUGPR01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:26:27 -0400
Date: Fri, 16 Jul 2004 13:29:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
In-Reply-To: <40BDC553.4060809@shadowconnect.com>
Message-ID: <Pine.LNX.4.58.0407161328030.26950@montezuma.fsmlabs.com>
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org>
 <40BC9EF7.4060502@shadowconnect.com> <Pine.LNX.4.58.0406011228130.1794@montezuma.fsmlabs.com>
 <40BDC553.4060809@shadowconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004, Markus Lidel wrote:

> Zwane Mwaikambo wrote:
> >>>probably too large an area to be remapping.  Try remapping only the
> >>>memory area needed, and not the entire area.
> >>Is there a way, to increase the size, which could be remapped, or is
> >>there a way, to find out what is the maximum size which could be remapped?
> >>Thank you very much for the fast answer!
> > You could try a 4G/4G enabled kernel, /proc/meminfo tells you how much
> > vmalloc (ioremap) space there is too.
>
> VmallocTotal:   245752 kB
> VmallocUsed:    137720 kB
> VmallocChunk:   107904 kB
>
> Okay, i see the problem now, the largest piece of memory which could be
> allocated is 107904 kB, right?
>
> Is the 4G/4G split already in the kernel? If yes, which entry activates it?

No it's not in the current kernel, you'd have to download the patch, the
most uptodate being the one in the Fedora/Redhat kernel tree.
