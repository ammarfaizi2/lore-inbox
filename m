Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbTIIU3m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTIIU1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:27:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47751 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264437AbTIIUYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:24:44 -0400
Date: Tue, 9 Sep 2003 22:24:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs explaining to you?
Message-ID: <20030909202443.GA20800@suse.de>
References: <20030823114738.B25729@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308250840360.1157-100000@cherise> <20030825172737.E16790@flint.arm.linux.org.uk> <20030901120208.GC1358@openzaurus.ucw.cz> <20030902174126.GB14209@suse.de> <1063138756.642.48.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063138756.642.48.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09 2003, Benjamin Herrenschmidt wrote:
> 
> > ide-cd should have a flush write cache as well, for mtr, dvd-ram, cd-rw
> > with packet writing, etc.
> 
> This is currently not done by the ide-cd suspend state machine, I did
> the infrastructure and ide-disk implementation, but I'm leaving things
> like ide-cd to you :)

That is fine, I'll take care of it :). Just wanted to point out that it
is indeed _not_ a given that ide-cd doesn't need sync cache support.

-- 
Jens Axboe

