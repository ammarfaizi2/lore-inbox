Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265613AbSJaXLa>; Thu, 31 Oct 2002 18:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265483AbSJaXIy>; Thu, 31 Oct 2002 18:08:54 -0500
Received: from ns.suse.de ([213.95.15.193]:31503 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265485AbSJaXH4>;
	Thu, 31 Oct 2002 18:07:56 -0500
Date: Fri, 1 Nov 2002 00:14:22 +0100 (CET)
From: Bernhard Kaindl <bk@suse.de>
To: <linux-kernel@vger.kernel.org>
Cc: <lkcd-general@lists.sourceforge.net>
Subject: Re: [lkcd-general] Re: What's left over.
In-Reply-To: <20021031162026.A12486@q.mn.rr.com>
Message-ID: <Pine.LNX.4.33.0210312332160.6945-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Shawn wrote:
>
> Linus has to "keep up" with all the changees coming into his inbox as
> well, and the more features, the more breakage that can happen when
> Linus accepts a patch.

Yes, but lkcd differs from the other changes because it can make the
life of people easyer which don't need the patch in the first place,
and help quality and shorten the time to fix bugs.

If someone triggers a problem, one can take a free partition or setup
an network dump server, run and if it happens again, there is a good
chance that all that is needed to fix the problem is in the dump,
the System.map and the Kerntypes file from the kernel which can
be consolidatet into a report with symbolic stack traces of the
CPUs and Tasks quite easy.

Original source, patches and configuration options are good for
analysing but not required if the Kerntypes file is there. The
config options could be even read from the dump if this would
be a liked feature. :-)

> Really, Linus wants to push some of his maintanance overhead to distros,
> who get paid to do it, but also to provide sexy bullet point items for
> users, so they buy "Linux" stuff.

Sure, but the work of the distros could be even better if the base
kernel has lkcd, LTT and dprobes (you don't have to enable them if
you don't need them) because then they would have more resources
to make other even more useful things. But it's up to someone
who merges the stuff.

Bernd


