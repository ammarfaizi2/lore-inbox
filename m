Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTIPJUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 05:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbTIPJUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 05:20:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51355 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261817AbTIPJUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 05:20:39 -0400
Date: Tue, 16 Sep 2003 11:20:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Ian Hastie <ianh@iahastie.clara.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <20030916092040.GB930@suse.de>
References: <20030910114346.025fdb59.akpm@osdl.org> <63090000.1063303982@flay> <20030911215238.GN12021@suse.de> <200309160134.28169.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309160134.28169.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16 2003, Ian Hastie wrote:
> On Thursday 11 Sep 2003 22:52, Jens Axboe wrote:
> > On Thu, Sep 11 2003, Martin J. Bligh wrote:
> > >
> > > Symptoms are that it required cdrecord-pro, which was a closed source
> > > piece of turd I can't do much with ;-)
> >
> > Surely the pro version supports open-by-device as well? And then it
> > should work fine.
> 
> It does.  However it also produces the same error message as cdrecord when 
> doing so, ie
> 
> Warning: Open by 'devname' is unintentional and not supported.
> 
> The implication being that it could go away or become broken at any time.

I wouldn't read anything in to that if I were you. Joerg has some mis
guided ideas about ATAPI addressing, but he would be a fool to remove
open by devname at this point.

-- 
Jens Axboe

