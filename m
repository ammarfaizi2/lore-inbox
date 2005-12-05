Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbVLEUwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbVLEUwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVLEUwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:52:44 -0500
Received: from mail.enyo.de ([212.9.189.167]:50364 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1751455AbVLEUwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:52:43 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark Lord <lkml@rtr.ca>, Rob Landley <rob@landley.net>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de>
	<200512042131.13015.rob@landley.net> <4394681B.20608@rtr.ca>
	<1133800090.21641.17.camel@mindpipe>
	<20051205164418.GA12725@merlin.emma.line.org>
	<1133803048.21641.48.camel@mindpipe>
	<20051205175518.GA21928@merlin.emma.line.org>
Date: Mon, 05 Dec 2005 21:52:08 +0100
In-Reply-To: <20051205175518.GA21928@merlin.emma.line.org> (Matthias Andree's
	message of "Mon, 5 Dec 2005 18:55:18 +0100")
Message-ID: <873bl76zd3.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthias Andree:

> Basically, no-one should have permission to touch any core parts, except
> for fixes, until 2.7. Yes, that means going back to older models. Yes,
> that means that the discussions will start all over. And yes, that means
> that the cool stuff has to wait. Solution: release more often.

Would this alone change much?  I think what we really want is that our
favorite branch (whatever it is) gets critical fixes forever (well,
maybe one or two years, but this is forever).  This is a bit
unrealistic because everyone has a slightly different branchpoint.
Releasing more often doesn't change that, really.

In the security area, I think there is enough experience out there to
collect data which would help each local branch maintainer to install
the relevant fixes.  But for general development, this seems to be
infeasible, unless you focus your software architecture on this
purpose (which is probably a terrible idea to do for kernel
development).
