Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUBLQJq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266501AbUBLQJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:09:46 -0500
Received: from node-402418b2.mdw.onnet.us.uu.net ([64.36.24.178]:40946 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S266498AbUBLQJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:09:44 -0500
Date: Thu, 12 Feb 2004 10:07:46 -0600
From: Brandon Low <lostlogic@gentoo.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About highmem in 2.6
Message-ID: <20040212160746.GB7002@lostlogicx.com>
References: <1o6EZ-2zO-27@gated-at.bofh.it> <1o7AZ-3PD-9@gated-at.bofh.it> <402A7EC6.7010003@nl.tiscali.com> <20040211212858.2ce1a17d.bonganilinux@mweb.co.za> <m3isidkkr6.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3isidkkr6.fsf@defiant.pm.waw.pl>
X-Operating-System: Linux found.lostlogicx.com 2.6.1-mm2
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02/12/04 at 05:02:53 +0100, Krzysztof Halasa wrote:
> Bongani Hlope <bonganilinux@mweb.co.za> writes:
> 
> > There is nothing wrong with that patch, the problem with Highmem support
> > on x86 is that is uses an Intel hack to address the full 1Gb of memory,
> > which make memory access a bit slower. The question is, does the 128Mb
> > additional memory worth that penalty?
> 
> 2GB/2GB split doesn't use any Intel hack nor highmem. In fact for
> 1 GB of RAM I use a little different split which covers the whole RAM
> and gives more virtual RAM, something like 1.2/2.8 GB.

Any chance of me getting a copy of the patch which allows the finer
grained tuning of the kernel/user split?

Thanks.

Brandon Low
> -- 
> Krzysztof Halasa, B*FH
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
