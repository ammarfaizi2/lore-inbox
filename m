Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTI3MfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbTI3MfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:35:24 -0400
Received: from rth.ninka.net ([216.101.162.244]:15747 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261413AbTI3MfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:35:15 -0400
Date: Tue, 30 Sep 2003 05:34:59 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: ast@domdv.de, schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-Id: <20030930053459.6cf2bd51.davem@redhat.com>
In-Reply-To: <20030930122832.GO2908@suse.de>
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de>
	<20030930115411.GL2908@suse.de>
	<3F797316.2010401@domdv.de>
	<20030930052337.444fdac4.davem@redhat.com>
	<20030930122832.GO2908@suse.de>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 14:28:32 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Tue, Sep 30 2003, David S. Miller wrote:
> > On Tue, 30 Sep 2003 14:12:06 +0200
> > Andreas Steinmetz <ast@domdv.de> wrote:
> > 
> > Indeed, and equally someone tell me where all the IPSEC socket
> > interface defines are in glibc?  It doesn't matter which tree
> > you check it won't be there.
> 
> Did you notify them of the addition?

Nope, and I don't expect them to be checking all the time.

This is as much kernel people's problem as glibc people's.
We, as kernel people, need a system that the glibc people can
get this crap automatically.  The glibc folks can then just use
it and everything just works.

> Well then change that to 'if you include kernel headers from your user
> apps, be prepared to pick fix the breakage'.

There is a very small amount of effort necessary to fix this
particular problem, it won't be the end of the world if we fix the
kernel header in the actual kernel sources for them.
