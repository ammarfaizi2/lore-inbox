Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTI3M26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTI3M26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:28:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63718 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261409AbTI3M2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:28:35 -0400
Date: Tue, 30 Sep 2003 14:28:32 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andreas Steinmetz <ast@domdv.de>, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930122832.GO2908@suse.de>
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de> <20030930052337.444fdac4.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930052337.444fdac4.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30 2003, David S. Miller wrote:
> On Tue, 30 Sep 2003 14:12:06 +0200
> Andreas Steinmetz <ast@domdv.de> wrote:
> 
> > Then please tell me why PPPIOCNEWUNIT is only defined in linux/if_ppp.h 
> > and not net/if_ppp.h which is still true for glibc-2.3.2. And please 
> > don't tell me to ask the glibc folks. There are inconsistencies between 
> > kernel headers and userland headers which force the inclusion of kernel 
> > headers in userland applications.
> 
> Indeed, and equally someone tell me where all the IPSEC socket
> interface defines are in glibc?  It doesn't matter which tree
> you check it won't be there.

Did you notify them of the addition?

> Even if one is of the opinion that nobody should be including the
> kernel headers, you must fully realize that as a matter of
> practicality people absolutely must do this to use many kernel
> interfaces to their full extent.
> 
> Suggest changes to fix the problems, but just saying "don't include
> kernel header in your user apps, NYAH NYAH NYAH!" does not help
> anyone at all.

Well then change that to 'if you include kernel headers from your user
apps, be prepared to pick fix the breakage'.

Surely the kernel doesn't move at such an accelerated pace that it's
impossible to keep kernel headers uptodate.

-- 
Jens Axboe

