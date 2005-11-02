Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbVKBQ02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbVKBQ02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVKBQ02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:26:28 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:32995 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965129AbVKBQ01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:26:27 -0500
Date: Wed, 2 Nov 2005 11:26:26 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Setting kernel data breakpoints on x86
In-Reply-To: <20051102071438.GA5050@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0511021125520.4928-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Maneesh Soni wrote:

> On Tue, Nov 01, 2005 at 04:30:26PM -0500, Alan Stern wrote:
> > I'm trying to debug a rather difficult data-overwriting problem, and it 
> > would be a big help to be able to use a data breakpoint.
> > 
> > Is there any easy way of doing this?  I'd prefer not to use a kernel 
> > debugger, because the address of the breakpoint and the time when it's 
> > needed are determined dynamically.
> > 
> > Does anybody have a little lightweight procedure for setting one of the 
> > x86's debug registers to point to a particular location in kernel memory 
> > space?  I don't care if the whole system crashes when the debug exception 
> > occurs, just so long as I can get a stack trace and find out where the 
> > overwrite comes from.
> > 
> > 
> 
> Hi Alan
> 
> Probably watchpoint probes could be useful for this..
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0508.3/1407.html
> 
> http://sourceware.org/ml/systemtap/2005-q3/msg00097.html

Hi Maneesh:

That's exactly what I was looking for.  Thanks!

Alan Stern

