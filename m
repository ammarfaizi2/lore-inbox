Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSLCMKV>; Tue, 3 Dec 2002 07:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbSLCMKV>; Tue, 3 Dec 2002 07:10:21 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:42676 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265414AbSLCMKU>;
	Tue, 3 Dec 2002 07:10:20 -0500
Date: Tue, 3 Dec 2002 12:15:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org?
Message-ID: <20021203121521.GB30431@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 02:24:04AM -0500, Valdis.Kletnieks@vt.edu wrote:
 > Out of curiosity, is it preferred that if bugs/patches get found, that they
 > be posted here, to the Bugzilla database, or both?  I've been putting them
 > at both places, so there's discussion here and a history there...

- simple things like compile errors
  here. no need to clog up bugzilla with lots of trivial things.

- architecture xxx doesn't compile
  there's a few of these now in bugzilla, and personally I don't think
  they belong there. Any arch other than i386 is always going to be
  playing catchup, and is nearly always out of date in mainline.

- trivial patches
  send to rusty, cc here.

- anything else
  here. if you don't get a quick-fix, bugzilla it too.
  this way important bugs won't get lost amongst the archives.
  (as long as bugzilla remains usable)

whilst on the subject of bugzilla:
a few people (myself included) go through the bug database once a week
or so pruning out-of-date/fixed entries. So far the ones I've closed have
been quite sensible, but there are a few there of the form..

"xxx doesn't work in 2.5.47", then Rusty's module rewrite happened,
and the tester didn't (or couldn't) see if it got fixed in subsequent
kernels. I'll send out pings to such reports when they get to something
like 5 kernels old. If the problem then doesn't get re-ACKed, I'll
close it. Any objections?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
