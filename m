Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTI3Mnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbTI3Mnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:43:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26859 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261449AbTI3Mmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:42:40 -0400
Date: Tue, 30 Sep 2003 14:42:38 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ast@domdv.de, schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930124238.GS2908@suse.de>
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de> <20030930052337.444fdac4.davem@redhat.com> <20030930122832.GO2908@suse.de> <20030930053459.6cf2bd51.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930053459.6cf2bd51.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30 2003, David S. Miller wrote:
> On Tue, 30 Sep 2003 14:28:32 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> > On Tue, Sep 30 2003, David S. Miller wrote:
> > > On Tue, 30 Sep 2003 14:12:06 +0200
> > > Andreas Steinmetz <ast@domdv.de> wrote:
> > > 
> > > Indeed, and equally someone tell me where all the IPSEC socket
> > > interface defines are in glibc?  It doesn't matter which tree
> > > you check it won't be there.
> > 
> > Did you notify them of the addition?
> 
> Nope, and I don't expect them to be checking all the time.
> 
> This is as much kernel people's problem as glibc people's.
> We, as kernel people, need a system that the glibc people can
> get this crap automatically.  The glibc folks can then just use
> it and everything just works.

Yep, the 'notify them' implies active effort from the kernel developers.

> > Well then change that to 'if you include kernel headers from your user
> > apps, be prepared to pick fix the breakage'.
> 
> There is a very small amount of effort necessary to fix this
> particular problem, it won't be the end of the world if we fix the
> kernel header in the actual kernel sources for them.

I'm sure Joerg is quite capable of fixing the problem and making a
patch. That is the least he can do if he wants the problem to be fixed,
whining is well known to be a lot less effective than that.

-- 
Jens Axboe

