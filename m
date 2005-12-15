Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVLOWrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVLOWrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVLOWrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:47:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751165AbVLOWrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:47:20 -0500
Date: Thu, 15 Dec 2005 14:47:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>, Deepak Saxena <dsaxena@plexity.net>
Cc: jordan.crouse@amd.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, info-linux@ldcmail.amd.com
Subject: Re: Geode LX HW RNG Support
Message-Id: <20051215144742.3463430a.akpm@osdl.org>
In-Reply-To: <43A1E91A.4060400@pobox.com>
References: <20051215211248.GE11054@cosmic.amd.com>
	<20051215211423.GF11054@cosmic.amd.com>
	<20051215133917.3f0a5171.akpm@osdl.org>
	<20051215214432.GB14013@cosmic.amd.com>
	<20051215140622.53c37335.akpm@osdl.org>
	<43A1E91A.4060400@pobox.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > "Jordan Crouse" <jordan.crouse@amd.com> wrote:
> > 
> >>>Should all the Geode additions to hw_random.c be inside __i386__, like VIA?
> >>
> >>I thought that a early version did that and somebody took exception to 
> >>it, but I can't find any e-mails to that effect right now.  Obviously, 
> >>the defines are only useful when you have a Geode CPU (and thus a x86_32), 
> >>so if nobody complains, I think that would be fine.
> > 
> > 
> > Fair enough.  Please send an update sometime.
> > 
> > We might as well do s/__i386__/X86_32/ throughout that file - bit pointless
> > but it's a little bit more idiomatic.
> 
> What about the rng rewrite recently posted?  Any opinions on that?

(http://lkml.org/lkml/2005/10/29/145)

Looks sane.  It ended up with Deepak deciding to split the various
manufacturer bits apart and then send the patches in my direction.  I don't
think that happened?

> I lean towards applying it, long term, but IIRC there were problems that 
> prevented immediate merge.

There was some talk about moving functionality to userspace, but it seems a
bit speculative.
