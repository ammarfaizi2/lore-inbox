Return-Path: <linux-kernel-owner+w=401wt.eu-S1750804AbWLNTd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWLNTd4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWLNTd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:33:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45226 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbWLNTdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:33:55 -0500
Date: Thu, 14 Dec 2006 14:32:29 -0500
From: Bill Nottingham <notting@redhat.com>
To: Rik van Riel <riel@redhat.com>
Cc: Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214193229.GB10955@nostromo.devel.redhat.com>
Mail-Followup-To: Rik van Riel <riel@redhat.com>, Greg KH <gregkh@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
	Martin Bligh <mbligh@mbligh.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <20061214051015.GA3506@nostromo.devel.redhat.com> <20061214084820.GA29311@suse.de> <4581595C.7080508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4581595C.7080508@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel (riel@redhat.com) said: 
> Maybe we should just educate users and teach them to
> avoid crazy unsupportable configurations and simply buy
> the hardware that has open drivers available?

Educating the users may help, but it's hard to do the
education once they've already bought the hardware. Generally,
it would be 1) buy hardware 2) run whatever comes with it
3) try Linux. Hard to get the 'if you're ever thinking about
running Linux, don't buy XYZ' into that workflow.

> Sure, the process of getting drivers merged upstream[2] can
> take some time and effort, but the resulting improvements in
> driver performance and stability are often worth it.  It's
> happened more than once that the Linux kernel community's
> review process turned up some opportunities for a 30% performance
> improvement in a submitted driver.
> 
> Hardware companies: can you afford to miss out on the stability
> and performance improvements that merging a driver upstream tends
> to get?
> 
> Can you afford to miss out when your competitors are getting these
> benefits?

This is the big point - we need to show the vendors how getting
upstream helps them.

Compare costs of all-in-house development versus shared-with-community
development.

Compare how quickly issues are fixed, and how often drivers actually
regress with in-tree vs. out-of-tree drivers.

Get case studies of drivers that have been opened (qeth? lpfc? Others?)
and get other companies to *go on the record* on how opening their
drivers and getting them upstream has helped them to lower their development
costs and scale their sales.

Bill
