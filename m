Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWJIHmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWJIHmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWJIHmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:42:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932317AbWJIHmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:42:24 -0400
Date: Mon, 9 Oct 2006 00:42:09 -0700
From: Bryce Harrington <bryce@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       hotplug_sig@osdl.org, lhcs-devel@lists.sourceforge.net
Subject: Re: Status on CPU hotplug issues
Message-ID: <20061009074209.GB27474@osdl.org>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org> <20061006162924.344090f8.akpm@osdl.org> <20061007102419.GB30034@elf.ucw.cz> <20061007202521.GA24743@osdl.org> <20061008191350.GB3788@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008191350.GB3788@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 09:13:50PM +0200, Pavel Machek wrote:
> > > So... patch-2.6.18-git4 failed to boot on all architectures? I'm
> > > seeing very little green fields there... actually I only see two green
> > > fields in whole table.
> > 
> > No, it failed to build due to a patching issue that has since been fixed
> > (I can rerun those older runs if there is interest.)
> 
> Reruning few of them and deleting rest from table would be nice.

I've requeued a few.  The runs will auto-expunge from the results in a
week or two.

> > > > iirc Pavel did some testing a month or two ago and was seeing userspace
> > > > misbehaviour?
> > > 
> > > Pavel did some testing (like two threads trying to plug/unplug cpus at
> > > the same time), and seen machines dying real fast; but that was fixed,
> > > IIRC, and I did not really torture it after that.
> > 
> > If this test is available, I could include it in my test runs if you
> > think it would be worth tracking.
> 
> Is shell script acceptable form of a test?

Yes.  In fact all the tests are shell scripts so far.

Bryce
