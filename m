Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVGLCf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVGLCf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 22:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVGLCf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 22:35:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261805AbVGLCfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 22:35:23 -0400
Date: Mon, 11 Jul 2005 19:34:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zanussi@us.ibm.com, linux-kernel@vger.kernel.org, karim@opersys.com,
       varap@us.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
Message-Id: <20050711193409.043ecb14.akpm@osdl.org>
In-Reply-To: <20050712022537.GA26128@infradead.org>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050712022537.GA26128@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jul 11, 2005 at 08:10:42PM -0500, Tom Zanussi wrote:
> > 
> > Hi Andrew, can you please merge relayfs?  It provides a low-overhead
> > logging and buffering capability, which does not currently exist in
> > the kernel.
> 
> While the code is pretty nicely in shape it seems rather pointless to
> merge until an actual user goes with it.

Ordinarily I'd agree.  But this is a bit like kprobes - it's a funny thing
which other kernel features rely upon, but those features are often ad-hoc
and aren't intended for merging.

relayfs is more for in-kernel "applications" than for userspace ones, if
you like.

Still, first let us get a handle on who wants relayfs now and in the future
and for what.  Then we can better decide.
