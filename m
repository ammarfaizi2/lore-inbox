Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWD2AC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWD2AC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 20:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWD2AC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 20:02:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53153 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750936AbWD2AC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 20:02:56 -0400
Date: Fri, 28 Apr 2006 17:05:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] catch valid mem range at onlining memory
Message-Id: <20060428170519.1194b077.akpm@osdl.org>
In-Reply-To: <20060428234410.GA7598@kroah.com>
References: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com>
	<20060428163409.389e895e.akpm@osdl.org>
	<20060428234410.GA7598@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > This all looks fairly (but trivially) dependent upon the 64-bit-resource
> > patches in Greg's tree.  Greg, were you planning on merging them in the
> > post-2.6.17 flood?
> 
> Yes, I was,

OK, thanks.

> unless there are any objections to me doing this?

I'd consider the patches as they stand to be ready to roll.

All the code bloat's a bit sad though.  It would have been nice to have
made the type of resource.start and .end Kconfigurable.  What happened
to that?

