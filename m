Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWAJTFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWAJTFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWAJTFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:05:23 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:8609 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932237AbWAJTFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:05:23 -0500
Subject: Re: 2G memory split
From: Dave Hansen <haveblue@us.ibm.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <43C4049E.6020105@rtr.ca>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>
	 <20060110133728.GB3389@suse.de>
	 <Pine.LNX.4.63.0601100840400.9511@winds.org>
	 <20060110143931.GM3389@suse.de>
	 <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
	 <43C3F986.4090209@mbligh.org>
	 <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org>
	 <1136919312.2557.77.camel@localhost.localdomain>  <43C4049E.6020105@rtr.ca>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 11:05:19 -0800
Message-Id: <1136919920.2557.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 14:01 -0500, Mark Lord wrote:
> Dave Hansen wrote:
> >
> > It actually "just works".  We have a 16GB machine that gets a lot of
> > filesystem activity and use a 2:2 split all the time.  Appended patch is
> > all that we need.
> 
> Your (tested) patch is not the same as what is being proposed here,
> so the testing experience probably doesn't apply.
> 
> The 2:2 boundary is different here.

That'll teach me not to read the patch.  That actually makes the link I
sent more topical because it allowed the user:kernel split with PAE to
occur away from hard PMD boundaries.

-- Dave

