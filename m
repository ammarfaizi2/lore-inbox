Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbTHSSmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTHSSmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:42:06 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34826
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272342AbTHSS0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:26:15 -0400
Date: Tue, 19 Aug 2003 11:26:14 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Anthony R." <russo.lutions@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030819182614.GC19465@matchmail.com>
Mail-Followup-To: "Anthony R." <russo.lutions@verizon.net>,
	linux-kernel@vger.kernel.org
References: <3F41AA15.1020802@verizon.net> <200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua> <3F42342A.8050605@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F42342A.8050605@verizon.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 10:28:58AM -0400, Anthony R. wrote:
> 
> >>another program needs more memory, so it shouldn't swap, but that is not
> >>the
> >>behaviour I am seeing.
> >>
> >>Can anyone help point me in the right direction?
> >>    
> >>
> >
> >I'd say stop allocating insane amounts of swap.
> >Frankly, with 2G you may run without swap at all.
> >  
> >
> I'm not sure how you knew I had 2GB of swap. ;)
> I just always thought it was a good idea to have some just in case.
> I did not know having swap would actually, in some cases, degrade
> performance.
> 
> Are you saying that, if I turn off swap, the amount of cache used will
> be the same, but that when other programs need more memory, the kernel
> will take it from cache? If so, I will try, since that would be
> an ideal solution.

And the -aa and rmap kernels do that with swap on too.

If you test them and they don't for your workload, please get back to the
list and let use know.

It is well known that the stock 2.4 VM is WAY behind -aa and rmap in terms
of reactiveness and correct choices.
