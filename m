Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUBVRcn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUBVRcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:32:43 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:3081 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S261706AbUBVRcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:32:41 -0500
Date: Sun, 22 Feb 2004 12:32:36 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0402210917220.482543-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0402221227200.374124-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Feb 2004, Ron Peterson wrote:
> On Fri, 20 Feb 2004, Andrew Morton wrote:
> 
> > There are a few things you should try - you probably already have:
> > 
> > - Stop all applications, restart them
> > 
> > - Unload net driver module, reload and reconfigure it.
> > 
> > If either of those (or similar operations) are found to bring the latency
> > back to normal then that would be a big hint.  ie: we need to find
> > something which brings the performance back apart from a complete reboot.

This machine is starting to head south again.  I've updated user.log (a
bunch of stats I'm syslogging) at
http://depot.mtholyoke.edu:8080/tmp/.  I've also added
http://depot.mtholyoke.edu:8080/tmp/mist/10/, which contains the latest 
smokeping graphs.

In about an hour or two, I'll likely have to head in to get this thing
back on its feet.  I will try the suggestions above, to see if that will
do the trick.  Is there anything else I should try to do or look at?  Once
I reboot (if that's what I have to do), I expect it will be a couple of
days before this happens again.

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

