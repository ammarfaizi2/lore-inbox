Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTIMVzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 17:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTIMVzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 17:55:40 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:55570 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262223AbTIMVzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 17:55:39 -0400
Date: Sun, 14 Sep 2003 00:04:01 +0200
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
Message-ID: <20030913220401.GA17528@hh.idb.hist.no>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com> <20030913174825.GB7404@mail.jlokier.co.uk> <1063476152.24473.30.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063476152.24473.30.camel@localhost>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 04:52:56PM -0400, Robert Love wrote:
> On Sat, 2003-09-13 at 13:48, Jamie Lokier wrote:
> 
> > Also, when the OOM condition is triggered I'd like the system to
> > reboot, but first try for a short while to unmount filesystems cleanly.
> > 
> > Any chance of those things?
> 
> I like all of these ideas.
> 
> One thing to keep in mind is that during a real OOM condition, we cannot
> allocate _any_ memory.  None. Zilch.
> 
So a "complicated" oom handler need to preallocate all the memory
it might ever need.  Not impossible.

Helge Hafting
