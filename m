Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSJWQEm>; Wed, 23 Oct 2002 12:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSJWQEm>; Wed, 23 Oct 2002 12:04:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:8672 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262692AbSJWQEk>;
	Wed, 23 Oct 2002 12:04:40 -0400
Subject: Re: [PATCH] extended ptrace
From: Paul Larson <plars@linuxtestproject.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Frank Cornelis <fcorneli@elis.rug.ac.be>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021023160144.GA11558@nevyn.them.org>
References: <Pine.LNX.4.44.0210231656080.19811-100000@trappist.elis.rug.ac.be>
	<1035387198.3447.39.camel@plars>  <20021023160144.GA11558@nevyn.them.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Oct 2002 11:00:13 -0500
Message-Id: <1035388815.5646.42.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 11:01, Daniel Jacobowitz wrote:
> On Wed, Oct 23, 2002 at 10:33:17AM -0500, Paul Larson wrote:
> > On Wed, 2002-10-23 at 10:01, Frank Cornelis wrote:
> > > Hi,
> > > 
> > > A new extended ptrace patch is available at:
> > > 	http://www.elis.rug.ac.be/~fcorneli/downloads/devel/exptrace-0.3.1.patch.gz
> > Do you (or anyone else) have any good tests for this, or even ptrace in
> > general?  I'm working on some ptrace tests for LTP, but if someone
> > already has something to contribute it would save me some time. :)
> 
> GDB and gdbserver get a good range of it; just pick a couple of the
> standard tests (to avoid problems with all the GDB bugs the testsuite
> turns up :).  I have some more precise tests but they're for
> features that haven't been accepted yet.
Precise tests that can be automated and ran under our test harness are
more along the lines of what I'm looking for.  If those features do go
in, it might be nice to have them in LTP if you don't mind.

Thanks,
Paul Larson

