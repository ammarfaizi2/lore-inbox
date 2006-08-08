Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWHHXuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWHHXuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWHHXuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:50:25 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:21147 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030330AbWHHXuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:50:24 -0400
Date: Tue, 8 Aug 2006 19:50:04 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Nigel Cunningham <nigel@suspend2.net>
cc: Lee Revell <rlrevell@joe-job.com>, LKML <linux-kernel@vger.kernel.org>,
       Suspend2-devel@lists.suspend2.net, linux-pm@osdl.org, pavel@suse.cz
Subject: Re: swsusp and suspend2 like to overheat my laptop
In-Reply-To: <200608090942.12404.nigel@suspend2.net>
Message-ID: <Pine.LNX.4.58.0608081948100.18586@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0608081831580.18586@gandalf.stny.rr.com>
 <1155080145.26338.130.camel@mindpipe> <200608090942.12404.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Aug 2006, Nigel Cunningham wrote:

> Hi.
>
> On Wednesday 09 August 2006 09:35, Lee Revell wrote:
> > On Tue, 2006-08-08 at 19:31 -0400, Steven Rostedt wrote:
> > > On Wed, 9 Aug 2006, Nigel Cunningham wrote:
> > > > The problem will be ACPI related, not particular to swsusp or Suspend2,
> > > > which is why you're seeing it with both implementations. I would
> > > > suggest that you contact the ACPI guys, and also look to see whether
> > > > there is a bios update available and/or a DSDT override for your
> > > > machine. The later will help if the problem is with your particular
> > > > machine's ACPI support, the former if it's a more general ACPI issue.
> > >
> > > Thanks for the response Nigel,
> > >
> > > There does exist a recent bios update for this machine:
> > >
> > > http://www-307.ibm.com/pc/support/site.wss/document.do?sitestyle=lenovo&l
> > >ndocid=MIGR-58127
> > >
> > > Hmm, it requires windows, and I've already wiped out that partition.  I
> > > did a search but it seems really scary to update the BIOS via Linux.
> > >
> > > Anyone else out there have a Thinkpad G41 and has successfully upgraded
> > > their BIOS?
> >
> > I would just report it to the ACPI people.  It's a bug if Linux does not
> > work with the same BIOS + DSDT that the other OS works on.
>
> True. I was assuming (perhaps wrongly?) that Steven is interested in both
> getting the bug fixed and being able to hibernate while he waits for the ACPI
> guys to achieve bug-for-bug compatibility with M$; hence suggesting doing
> both.
>

I would prefer to do both, but I really can't tell you if the $OTHER_OS
works or not. I booted it once with this machine, and that was only to
register it with IBM. ;)

After that, I slapped in my Debian install CD and the rest is history.


-- Steve

