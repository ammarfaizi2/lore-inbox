Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbUC2REx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbUC2RE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:04:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:7337 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263014AbUC2Q7s (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 29 Mar 2004 11:59:48 -0500
Message-Id: <200403291659.i2TGxQ214736@mail.osdl.org>
Date: Mon, 29 Mar 2004 08:59:14 -0800 (PST)
From: markw@osdl.org
Subject: Re: Reiser4 needs more testers
To: reiser@namesys.com
cc: Nikita@namesys.com, Reiserfs-Dev@namesys.com, Reiserfs-List@namesys.com,
       Linux-Kernel@Vger.Kernel.ORG, cliff@lindows.com, tom.welch@lindows.com,
       garloff@suse.de, drobbins@gentoo.org, reiserrf@hotmail.com
In-Reply-To: <406462C1.5020507@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've run through another test on STP with the latest snapshot against
reiser4 and reiserfs for comparison.  Reiser4 still seems to be lagging
behind reiserfs in our DBT-2 workload (the bigger number is better in
the metric):

          metric  url to test results
          ------  ---------------------------------
reiser4   1208    http://khack.osdl.org/stp/290774/
reiserfs  1819    http://khack.osdl.org/stp/290775/

Mark

On 26 Mar, Hans Reiser wrote:
> We have one NFS related bug remaining, and one mmap all of memory 
> related bug (and performance issue) that you can hit using iozone.  We 
> will fix both of these in next week's snapshot, they were both multi-day 
> bug fixes.  When they are fixed, unless users/distros find bugs next 
> week we will submit it for inclusion in the -mm and then the official 
> kernel.
> 
> We hope it is now fairly stable for average users if you avoid those two 
> issues (we need to get rid of those dire warnings about its 
> stability...., we will remember that next snapshot....;-) )
> 
> We need a lot more real user testers, because we have run out of scripts 
> that can crash it, and there are distros that would like to ship it 
> soon.  Please also complain to vitaly@namesys.com and ramon@namesys.com 
> about poor documentation, etc., ....
> 
> The new reiser4 snapshot (against 2.6.5-rc2) is available at
> 
> http://www.namesys.com/snapshots/2004.03.26/

