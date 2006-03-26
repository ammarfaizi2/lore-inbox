Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWCZVjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWCZVjq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWCZVjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:39:45 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:53678 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932138AbWCZVjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:39:45 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jonathan Black <vampjon@gmail.com>
Subject: Re: uptime increases during suspend
Date: Sun, 26 Mar 2006 23:38:10 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
References: <20060325150238.GA9023@beacon.dhs.org> <200603251610.16566.rjw@sisk.pl> <20060325151818.GA10939@beacon.dhs.org>
In-Reply-To: <20060325151818.GA10939@beacon.dhs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603262338.10750.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 March 2006 16:18, Jonathan Black wrote:
> On Sat, Mar 25, 2006 at 04:10:16PM +0100, Rafael J. Wysocki wrote:
> > On Saturday 25 March 2006 16:02, Jonathan Black wrote:
> > > I'd like to enquire about the following behaviour:
> > > 
> > > $ uptime && sudo hibernate && uptime
> > >  14:18:51 up 1 day, 4:12,  2 users,  load average: 0.58, 3.30, 2.42
> > >  14:23:46 up 1 day, 4:17,  2 users,  load average: 20.34, 7.74, 3.91
> > > 
> > > I.e. the system was suspended to disk for 5 minutes, but the value
> > > reported by 'uptime' has increased by as much, as if it had actually
> > > continued running during that time.
> > > 
> > > I'm using Linux 2.6.16 with the latest version of the Suspend 2 patch
> > > (2.2.1), but Nigel its maintainer says that this isn't actually related
> > > to his suspend code, essentially the same would happen using the swsusp
> > > code currently in the kernel, and therefore we need to ask the kernel
> > > time code people about this issue.
> > 
> > Is your system an i386 or x86_64?
> 
> It is an i386.

This seems to happen on my box either, which is an x86_64, so it looks like
this doesn't depend on the architecture.  Investigating.

Rafael
