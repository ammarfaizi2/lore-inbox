Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWACVja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWACVja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWACVja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:39:30 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:195 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S964946AbWACVj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:39:29 -0500
Subject: Re: Benchmarks
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: Sharma Sushant <sushant@cs.unm.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060103213244.M41864@webmail.cs.unm.edu>
References: <20060103213244.M41864@webmail.cs.unm.edu>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 16:39:24 -0500
Message-Id: <1136324365.21485.19.camel@rockstar.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well that would very much depend on what you're changing.  For example,
if it is a file system modification, then use file system benchmarks.
However, those same benchmarks would not be appropriate for changes in
the network stack.  A pre-written benchmark may not even exist.  You
should use your knowledge of what you are changing to choose an
appropriate benchmark that will stress that part of the kernel.

Avishay Traeger
http://www.fsl.cs.sunysb.edu/~avishay/

On Tue, 2006-01-03 at 16:34 -0500, Sharma Sushant wrote:
> Hello everyone,
> If someone make some modifications to kernel code and want to know how much
> overead those modifications has caused, what are the benchmarks that one
> should use to calculate the overhead of the added code. 
> please cc the reply to me.
> Thanks a lot.
> 
> --
> Sushant Sharma
> http://cs.unm.edu/~sushant
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

