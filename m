Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbVLGW3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbVLGW3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVLGW3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:29:08 -0500
Received: from sanosuke.troilus.org ([66.92.173.88]:8646 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S1030408AbVLGW3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:29:07 -0500
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Lee Revell <rlrevell@joe-job.com>,
       Dirk Steuwer <dirk@steuwer.de>, linux-kernel@vger.kernel.org
Subject: Re: Runs with Linux (tm)
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	<20051205121851.GC2838@holomorphy.com>
	<20051206011844.GO28539@opteron.random>
	<43944F42.2070207@didntduck.org>
	<loom.20051206T094816-40@post.gmane.org>
	<20051206104652.GB3354@favonius>
	<loom.20051206T173458-358@post.gmane.org>
	<20051207141720.GA533@kvack.org> <1133982741.17901.32.camel@mindpipe>
	<20051207194746.GG533@kvack.org> <439760FF.3060605@mnsu.edu>
From: Michael Poole <mdpoole@troilus.org>
Date: 07 Dec 2005 17:29:04 -0500
In-Reply-To: <439760FF.3060605@mnsu.edu>
Message-ID: <874q5k4k3z.fsf@graviton.dyn.troilus.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Hundstad writes:

> It might be possible to add a serial number to the logo, and keep a
> database that maintains a current status of the device in the Linux
> kernel.
> 
> Does this make sense?

Not especially.  To be accurate, it would have to be bumped every time
a driver is removed from the kernel -- or, more accurately, every time
the in-kernel API changes.  To be useful, such an increment would have
to only happen once a year or so, or else updating the packaging is
too much work.  Currently, the in-kernel API changes every month or
two, which means a driver compatibility serial number would be
inaccurate, futile, or both.

Michael Poole
