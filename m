Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbULQQgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbULQQgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbULQQge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:36:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15529 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261870AbULQQdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:33:02 -0500
Date: Fri, 17 Dec 2004 17:33:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.osdl.org,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: Cleanup PCI power states
Message-ID: <20041217163301.GA7917@atrey.karlin.mff.cuni.cz>
References: <20041217000526.GA11531@kroah.com> <Pine.LNX.4.44L0.0412171109260.1920-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0412171109260.1920-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hm, ok, can everyone agree (especially the linux-pm list people) that
> > the patch below is the way we are all moving toward?
> 
> Yes, provided it is clear that this code only gives a _default_ mapping 
> and that drivers will have access to the complete pm_message_t data so 
> they can choose a different mapping if they want.

Yes, that's the plan.
									Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
