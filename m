Return-Path: <linux-kernel-owner+w=401wt.eu-S1754688AbXAAVQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbXAAVQr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 16:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbXAAVQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 16:16:47 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53541 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754688AbXAAVQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 16:16:47 -0500
Date: Mon, 1 Jan 2007 21:26:40 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
Message-ID: <20070101212640.7268fb1d@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2007 12:13:08 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> Jeff, 
>  what was the resolution to this one? Just revert the offending commit, or 
> what?

If you revert the commit you end with all the PCI resource tree breakage
back
> 
> We're about five weeks into the 2.6.20-rc series. I was hoping for a 
> two-month release rather than the usual dragged-out three months, so I'd 
> like to get these regressions to be actively fixed. By forcible reverts if 
> that is what it takes.

The patch I sent ages back is perfectly adequate for 2.6.20-rc/2.6.20
final. Jeff is correct that it isn't perfection in all cases but it does
no real harm and the right fix (removing the whole bogus combined mode
garbage) is short and simple.

If Jeff doesn't get you a patch please let me know before reverting it
and I'll send you the one I'm using that folks have tested and works.

Alan
