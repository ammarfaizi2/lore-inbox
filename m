Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVAVFwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVAVFwH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 00:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVAVFwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 00:52:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:4551 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262354AbVAVFwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 00:52:05 -0500
Date: Fri, 21 Jan 2005 21:52:03 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Pollable Semaphores
Message-ID: <20050121215203.S469@build.pdx.osdl.net>
References: <20050121212212.GA453910@firefly.engr.sgi.com> <521xceqx90.fsf@topspin.com> <Pine.SGI.4.61.0501211647100.7393@kzerza.americas.sgi.com> <a36005b5050121194377026f39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a36005b5050121194377026f39@mail.gmail.com>; from drepper@gmail.com on Fri, Jan 21, 2005 at 07:43:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ulrich Drepper (drepper@gmail.com) wrote:
> And is another thing to consider.  There is at least one other event
> which should be pollable: process (maybe threads) deaths.  I was
> hoping that we get support for this, perhaps in the form of polling
> the /proc/PID directory.  For poll(), a POLLERR value could mean the
> process/thread died.  For select(), once again a  bit in the except
> array could be set.

I have a simple patch that does just that.  It worked after brief testing,
then I never went back to look at it any more.  I'll see if I can't dig
it up, maybe it's useful.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
