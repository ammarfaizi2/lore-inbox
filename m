Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752049AbWCGK0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbWCGK0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 05:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbWCGK0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 05:26:20 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:15595 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1752049AbWCGK0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 05:26:20 -0500
Date: Tue, 7 Mar 2006 05:26:09 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: jonathan@jonmasters.org
cc: Lee Revell <rlrevell@joe-job.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Chris Ball <cjb@mrao.cam.ac.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] inotify hack for locate
In-Reply-To: <35fb2e590603061633w2dd7fff4m63e73ee8ed409951@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0603070524020.9699@gandalf.stny.rr.com>
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com> 
 <yd3bqwkbgsi.fsf@islay.ra.phy.cam.ac.uk>  <35fb2e590603051704k120e0257wb39c3e3eb1cf0b49@mail.gmail.com>
  <440C0175.7040909@aitel.hist.no> <1141690310.25487.97.camel@mindpipe>
 <35fb2e590603061633w2dd7fff4m63e73ee8ed409951@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Mar 2006, Jon Masters wrote:

> On 3/7/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Mon, 2006-03-06 at 10:31 +0100, Helge Hafting wrote:
> > > As for the non-existent virus problem - it is mostly prevented
> > > by users not being administrators.  And you can go further
> > > with a readonly /usr and a noexec /home.
>
> > I believe he is referring to using Linux systems to provide virus
> > scanning services for mail, NFS, SMB etc. clients, rather than to virus
> > scanning for the Linux desktop (which is indeed a non problem).
>
> Sure. I wasn't hand waving an muttering about virus problems on Linux
> desktops everywhere.
>
> Anyway. Seems a couple of us are interested in having something more
> generic at the VFS level to notify userspace about particular events
> of interest (recursively registering a watcher on every directory is
> silly). I really should go scope out some of the existing projects
> that cover this before I decide what to do. This kind of thing should
> be in mainline IMHO.
>

Hmm, this could also be very useful for change management systems and
especially backup utilities. Imagine having a daemon that records all the
changes on a filesystem, and then backs them up periodically. Could very
well be useful.

-- Steve
