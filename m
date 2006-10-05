Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWJEGhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWJEGhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 02:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWJEGhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 02:37:23 -0400
Received: from brick.kernel.dk ([62.242.22.158]:10802 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751509AbWJEGhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 02:37:21 -0400
Date: Thu, 5 Oct 2006 08:37:00 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc1: known regressions
Message-ID: <20061005063700.GH5170@kernel.dk>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061005042816.GD16812@stusta.de> <1160023503.22232.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160023503.22232.10.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05 2006, Benjamin Herrenschmidt wrote:
> On Thu, 2006-10-05 at 06:28 +0200, Adrian Bunk wrote:
> > Contrary to popular belief, there are people who test -rc kernels
> > and report bugs.
> > 
> > And there are even people who test -git kernels.
> > 
> > This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18.
> > 
> > If you find your name in the Cc header, you are either submitter of one
> > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > of you was declared guilty for a breakage or I'm considering you in any
> > other way possibly involved with one or more of these issues.
> > 
> > Due to the huge amount of recipients, please trim the Cc when answering.
> 
> Add sleep/wakeup on powerbooks apparently busted. Haven't tracked down
> yet.

Let me know if it appears to be ide related, there's a chance it could
be the same thing as:

Subject    : DVD drive lost DVD capabilities
References : http://lkml.org/lkml/2006/10/1/45
Submitter  : Olaf Hering <olaf@aepfle.de>
Guilty     : Jens Axboe <axboe@suse.de>
             commit 4aff5e2333c9a1609662f2091f55c3f6fffdad36
Handled-By : Jens Axboe <axboe@suse.de>
Status     : Jens is working on a fix

-- 
Jens Axboe

