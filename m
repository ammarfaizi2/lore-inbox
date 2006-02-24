Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWBXBFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWBXBFM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWBXBFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:05:12 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:37542
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932269AbWBXBFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:05:10 -0500
Date: Thu, 23 Feb 2006 17:04:46 -0800
From: Greg KH <greg@kroah.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Maneesh Soni <maneesh@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] sysfs_hash_and_remove (was Re: What protection ....)
Message-ID: <20060224010446.GA24841@kroah.com>
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com> <20051123081845.GA32021@elte.hu> <20051123125212.GD22714@in.ibm.com> <20060211003333.GA18575@kroah.com> <Pine.LNX.4.58.0602111041390.13323@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602111041390.13323@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 10:46:45AM -0500, Steven Rostedt wrote:
> On Fri, 10 Feb 2006, Greg KH wrote:
> 
> > On Wed, Nov 23, 2005 at 06:22:13PM +0530, Maneesh Soni wrote:
> > > Looks like here it is crashing due to bogus dentry pointer in the kobject
> > > kobj->dentry. Could be some stale pointer?
> >
> > Did you ever figure anything out here?  I'm seeing a lot more reports of
> > this problem lately, especially if you enable slab debugging.  For
> > example:
> > 	http://bugzilla.kernel.org/show_bug.cgi?id=5876
> >
> 
> The patch has just been added to the 2.6.16 series so if this does fix the
> bug, we wont know until someone tries one of the 2.6.16-rc kernels (or
> later).

Ugh, you're right, sorry for the noise.  Too many patches floating
around here :)

> Have you seen this bug in one of those kernels?

No I haven't.

thanks,

greg k-h
