Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVGBAGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVGBAGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 20:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVGBAGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 20:06:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261652AbVGBAGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 20:06:01 -0400
Date: Fri, 1 Jul 2005 17:06:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com,
       linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: Re: [uml-devel] Re: [PATCH 1/2] UML - skas0 - separate kernel
 address space on stock hosts
Message-Id: <20050701170648.2762c702.akpm@osdl.org>
In-Reply-To: <200507020157.37593.blaisorblade@yahoo.it>
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
	<20050701145802.5cebabd2.akpm@osdl.org>
	<200507020157.37593.blaisorblade@yahoo.it>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> On Friday 01 July 2005 23:58, Andrew Morton wrote:
> > Jeff Dike <jdike@addtoit.com> wrote:
> > > This patch implements something very close to skas mode for hosts
> > > which don't support skas - I'm calling this skas0.
> >
> > I note that this patch assumes that
> > uml-kill-some-useless-vmalloc-tlb-flushing.patch is applied.
>
> You're fixing the conflict anyway since it's little, correct?

Well I can fix the reject if we decide that
uml-kill-some-useless-vmalloc-tlb-flushing.patch is not to be applied, but
it seems that there's no need.

> However, for now it seems that I can't reproduce anyway the iptables crash, 
> and even Jeff did some testing... so it seems it's ok.

OK..

Now what about uml-remove-winch-sem.patch?  I have a "keep this in -mm"
sign next to it.

