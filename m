Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUCNAXb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUCNAXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:23:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:23514 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263228AbUCNAX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:23:29 -0500
Subject: Re: Dealing with swsusp vs. pmdisk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@zip.com.au>,
       torvalds@transmeta.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040313123620.GA3352@openzaurus.ucw.cz>
References: <20040312224645.GA326@elf.ucw.cz>
	 <20040313004756.GB5115@thunk.org> <1079146273.1967.63.camel@gaston>
	 <20040313123620.GA3352@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1079223482.1960.113.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Mar 2004 11:18:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 23:36, Pavel Machek wrote:
> Hi!
> 
> > > Pavel, what do you think of the swsusp2 patch, BTW?  My biggest
> > > complaint about it is that since it's maintained outside of the
> > > kernel, it's constantly behind about 0.75 revisions behind the latest
> > > 2.6 release.  The feature set of swsusp2, if they can ever get it
> > > completely bugfree(tm) is certainly impressive.
> > 
> > I'd like it to be merged upstream too.
> 
> Are we talking 2.6 or 2.7 here?

2.6. I don't see any problem merging it at this point as long as
it's not invasive (I haven't looked at the code though). If it's
self-contained, it's more/less like adding a driver.

Ben.


