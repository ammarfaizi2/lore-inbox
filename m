Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTIPS6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 14:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTIPS6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 14:58:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:47620
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262029AbTIPS6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 14:58:14 -0400
Date: Tue, 16 Sep 2003 11:58:35 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ian Hastie <ianh@iahastie.clara.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <20030916185835.GB13011@matchmail.com>
Mail-Followup-To: Ian Hastie <ianh@iahastie.clara.net>,
	linux-kernel@vger.kernel.org
References: <20030910114346.025fdb59.akpm@osdl.org> <200309160134.28169.ianh@iahastie.local.net> <20030916092040.GB930@suse.de> <200309161926.04549.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309161926.04549.ianh@iahastie.local.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 07:26:02PM +0100, Ian Hastie wrote:
> On Tuesday 16 Sep 2003 10:20, Jens Axboe wrote:
> > On Tue, Sep 16 2003, Ian Hastie wrote:
> > > On Thursday 11 Sep 2003 22:52, Jens Axboe wrote:
> > > > Surely the pro version supports open-by-device as well? And then it
> > > > should work fine.
> > >
> > > It does.  However it also produces the same error message as cdrecord
> > > when doing so, ie
> > >
> > > Warning: Open by 'devname' is unintentional and not supported.
> > >
> > > The implication being that it could go away or become broken at any time.
> >
> > I wouldn't read anything in to that if I were you. Joerg has some mis
> > guided ideas about ATAPI addressing, but he would be a fool to remove
> > open by devname at this point.
> 
> What about this version of the argument then?  There are a number if pieces of 
> software, eg cdrdao, that don't support open by devname.  The kernel 
> developers would be foolish to remove support for them at this time.  Works 
> both ways doesn't it.

This is one example where the kernel is pushing userspace forward.  There's
no need to add any drag to the momentum in this case.

Let's get those userspace apps converted over.  It will make many things
simpler.  Including other user space apps.
