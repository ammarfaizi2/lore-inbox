Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbUJYWFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUJYWFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 18:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbUJYWEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:04:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:16551 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261267AbUJYWBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:01:42 -0400
Date: Mon, 25 Oct 2004 15:05:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: smurf@smurf.noris.de, linux-kernel@vger.kernel.org
Subject: Re: BK kernel workflow
Message-Id: <20041025150506.258edc58.akpm@osdl.org>
In-Reply-To: <417D203B.4030508@pobox.com>
References: <41752E53.8060103@pobox.com>
	<20041019153126.GG18939@work.bitmover.com>
	<41753B99.5090003@pobox.com>
	<4d8e3fd304101914332979f86a@mail.gmail.com>
	<20041019213803.GA6994@havoc.gtf.org>
	<4d8e3fd3041019145469f03527@mail.gmail.com>
	<20041019232710.GA10841@kroah.com>
	<pan.2004.10.25.13.01.49.824742@smurf.noris.de>
	<417D203B.4030508@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Matthias Urlichs wrote:
> > Andrew also does things like
> > 
> > bk-netdev.patch
> > e1000-module_param-fix.patch
> > ne2k-pci-pci-build-fix.patch
> > r8169-module_param-fix.patch
> > 
> > which my mind translates as "there's something stupid, incomplete or
> > outdated in the bk-netdev tree", or "that tree's maintainer should apply
> > these patches. Now." (Ideally, of course, my import script should do the
> > same thing.)
> 
> Wrong on all counts.

"wrong" became "right".  Those patches need to be applied now.  I'll resend them.

But Matthias has described the algorithm correctly: I try to keep "fixups"
as close as possible to the patches which they fix.

I also try to keep patches in when-to-go-to-linus order, but that's much
harder to achieve, for various reasons.

