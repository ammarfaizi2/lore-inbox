Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVLEULK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVLEULK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVLEULJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:11:09 -0500
Received: from styx.suse.cz ([82.119.242.94]:51163 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S964787AbVLEULI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:11:08 -0500
Date: Mon, 5 Dec 2005 21:11:07 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joseph Jezak <josejx@gentoo.org>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051205211107.61941ab9@griffin.suse.cz>
In-Reply-To: <20051205194146.GA29317@infradead.org>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	<20051205190038.04b7b7c1@griffin.suse.cz>
	<4394892D.2090100@gentoo.org>
	<20051205195543.5a2e2a8d@griffin.suse.cz>
	<20051205191008.GA28433@infradead.org>
	<20051205203121.48241a08@griffin.suse.cz>
	<20051205194146.GA29317@infradead.org>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005 19:41:46 +0000, Christoph Hellwig wrote:
> None of them made it into the kernel tree.  As soon as we'll have an
> acceptable one everyone will have to use and improve it.  I personally
> couldn't care less what we start with.

Same with me.

> That's because you still don't get how we do development.  The last thing
> we want is full-scale rewrites.  Submit patches to fix things based on
> whatever you want but do it incremental.

We have got almost finished and working stack. Everything we need to do
is:
1. identify issues;
2. fix the issues; some of them will need broader discussion;
3. split it into several (potentially a lot of) reviewable patches;
4. clean up the drivers.

I'm in phase 2 now (no interesting results yet). I don't think it is
possible to start by phase 3 and then skip back to 1 and 2... This is
the reason I didn't post anything yet (or did you see some bloated
everything-rewriting patch from me posted on the list?).

But I also don't think it is worth effort to reinvent wheel by writing all
of the stuff again. This is the reason I started to examine Devicescape
code, nothing more.

And if you are familiar with the current in-kernel 802.11 code (and if
you know at least two different drivers), you will probably agree that
many things have to be changed in the current code even if we decided to
build on the top of it, so the result will finally differ a lot and will
be almost incompatible with the current code. (Why? I think I wrote some
explanation already to netdev list - if you don't find it or it is not
understandable, please let me know, I will try again.)


-- 
Jiri Benc
SUSE Labs
