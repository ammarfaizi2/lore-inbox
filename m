Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132267AbRCVXj3>; Thu, 22 Mar 2001 18:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132261AbRCVXhk>; Thu, 22 Mar 2001 18:37:40 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:35846 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132255AbRCVXgE>;
	Thu, 22 Mar 2001 18:36:04 -0500
Date: Thu, 22 Mar 2001 18:38:54 -0500
Message-Id: <200103222338.f2MNcsC17467@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: CML2 version 0.9.5 is available.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 0.9.5: Thu Mar 22 18:21:12 EST 2001
	* Put Python version guard up front so user won't see a stack
	  trace from bad imports.
	* Follow through on representing numbers as numbers internally.

My most persistent bug finder, Giacomo Catenazzi, reported no bugs in 0.9.4, 
but I found some.  The conversion of the internals to use numbers for
numbers rather than strings was incomplete.

It's very likely that the next CML2 release, just in time for the 2.5
kickoff workshop, will be 1.0.0.  I'm assuming kernel version 2.4.3 
will issue sometime before that and will resync the rules files with it.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Love your country, but never trust its government.
	-- Robert A. Heinlein.
