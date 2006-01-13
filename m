Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422814AbWAMSlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422814AbWAMSlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422818AbWAMSlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:41:22 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:45814 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422814AbWAMSlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:41:21 -0500
Date: Fri, 13 Jan 2006 13:41:16 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Dual core Athlons and unsynced TSCs
In-Reply-To: <1137174848.15108.11.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com> 
 <1137168254.7241.32.camel@localhost.localdomain>  <1137174463.15108.4.camel@mindpipe>
  <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com> <1137174848.15108.11.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jan 2006, Lee Revell wrote:

> On Fri, 2006-01-13 at 12:52 -0500, Steven Rostedt wrote:
> > On Fri, 13 Jan 2006, Lee Revell wrote:
> >
> > > I don't have hardware to test this, can you confirm that the only
> > > workaround needed is to boot with "clock=pmtmr"?
> >
> > For which kernel?
>
> I believe the problem exists on all kernels, it should not matter.


Well, I just booted up (and am currently running) 2.6.15-rt4-sr2 and I
used "clock=pmtmr".  I haven't got any

read_tsc: ACK! TSC went backward! Unsynced TSCs?


If that's what you want to know?

But the latency traces are still screwed up.


-- Steve

