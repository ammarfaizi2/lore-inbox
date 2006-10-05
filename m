Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWJEGy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWJEGy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 02:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWJEGy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 02:54:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:37602 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751150AbWJEGy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 02:54:58 -0400
Subject: Re: 2.6.19-rc1: known regressions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061005063700.GH5170@kernel.dk>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <20061005042816.GD16812@stusta.de>
	 <1160023503.22232.10.camel@localhost.localdomain>
	 <20061005063700.GH5170@kernel.dk>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 16:52:40 +1000
Message-Id: <1160031161.22232.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 08:37 +0200, Jens Axboe wrote:
> On Thu, Oct 05 2006, Benjamin Herrenschmidt wrote:
> > On Thu, 2006-10-05 at 06:28 +0200, Adrian Bunk wrote:
> > > Contrary to popular belief, there are people who test -rc kernels
> > > and report bugs.
> > > 
> > > And there are even people who test -git kernels.
> > > 
> > > This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18.
> > > 
> > > If you find your name in the Cc header, you are either submitter of one
> > > of the bugs, maintainer of an affectected subsystem or driver, a patch
> > > of you was declared guilty for a breakage or I'm considering you in any
> > > other way possibly involved with one or more of these issues.
> > > 
> > > Due to the huge amount of recipients, please trim the Cc when answering.
> > 
> > Add sleep/wakeup on powerbooks apparently busted. Haven't tracked down
> > yet.
> 
> Let me know if it appears to be ide related, there's a chance it could
> be the same thing as:

No idea yet, I had various reports mostly saying "black screen", both on
sleep and resume, there could be several issues. I need to finish some
other stuff and I'll look into it.

Ben.


