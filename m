Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTEMPA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbTEMPAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:00:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25040 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261367AbTEMPAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:00:21 -0400
Date: Tue, 13 May 2003 17:12:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513151254.GA17033@suse.de>
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk> <20030513150042.GA21126@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513150042.GA21126@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13 2003, Jeff Garzik wrote:
> On Tue, May 13, 2003 at 02:57:08PM +0100, Alan Cox wrote:
> > On Llu, 2003-05-12 at 23:55, Andrew Morton wrote:
> > > 
> > > - IDE tcq. Either kill it or fix it. Not a "big todo", as such.
> > > 
> > 
> > There are lots of other IDE bugs that wont go away until the taskfile
> > stuff is included,
> 
> Let me ask the dumb question then.  :)  I've been following the various
> IDE threads and see a lot of "X won't happen until taskfile IO is in"
> 
> What remains to do, until taskfile IO can go in?

Main issue is the bio walking stuff, which is just awaiting a Linus
commit. At least from the block layer side.

-- 
Jens Axboe

