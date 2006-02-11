Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWBKPq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWBKPq6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWBKPq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:46:58 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:35787 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932330AbWBKPq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:46:57 -0500
Date: Sat, 11 Feb 2006 10:46:45 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Greg KH <greg@kroah.com>
cc: Maneesh Soni <maneesh@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] sysfs_hash_and_remove (was Re: What protection ....)
In-Reply-To: <20060211003333.GA18575@kroah.com>
Message-ID: <Pine.LNX.4.58.0602111041390.13323@gandalf.stny.rr.com>
References: <1132695202.13395.15.camel@localhost.localdomain>
 <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com>
 <20051123081845.GA32021@elte.hu> <20051123125212.GD22714@in.ibm.com>
 <20060211003333.GA18575@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2006, Greg KH wrote:

> On Wed, Nov 23, 2005 at 06:22:13PM +0530, Maneesh Soni wrote:
> > Looks like here it is crashing due to bogus dentry pointer in the kobject
> > kobj->dentry. Could be some stale pointer?
>
> Did you ever figure anything out here?  I'm seeing a lot more reports of
> this problem lately, especially if you enable slab debugging.  For
> example:
> 	http://bugzilla.kernel.org/show_bug.cgi?id=5876
>

The patch has just been added to the 2.6.16 series so if this does fix the
bug, we wont know until someone tries one of the 2.6.16-rc kernels (or
later).

Have you seen this bug in one of those kernels?

-- Steve

