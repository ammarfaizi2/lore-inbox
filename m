Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbUCMC40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 21:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbUCMC40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 21:56:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:5337 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263038AbUCMC4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 21:56:22 -0500
Subject: Re: Dealing with swsusp vs. pmdisk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       torvalds@transmeta.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040313004756.GB5115@thunk.org>
References: <20040312224645.GA326@elf.ucw.cz>
	 <20040313004756.GB5115@thunk.org>
Content-Type: text/plain
Message-Id: <1079146273.1967.63.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Mar 2004 13:51:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Pavel, what do you think of the swsusp2 patch, BTW?  My biggest
> complaint about it is that since it's maintained outside of the
> kernel, it's constantly behind about 0.75 revisions behind the latest
> 2.6 release.  The feature set of swsusp2, if they can ever get it
> completely bugfree(tm) is certainly impressive.

I'd like it to be merged upstream too.

It may have problems, rough edges, whatever, but keeping out of tree
is more or less a guarantee that none of us will look & fix them ;)

If it gets upstream, I'll gladly finish the pmac support for it that
I quickly hacked recently for pmdisk as a proof of concept and help
figure out some of the remaining problems. I don't feel like doing
that with an out-of-tree project.

Ben

