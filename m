Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSJWP5k>; Wed, 23 Oct 2002 11:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265068AbSJWP5j>; Wed, 23 Oct 2002 11:57:39 -0400
Received: from crack.them.org ([65.125.64.184]:6917 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S265066AbSJWP5j>;
	Wed, 23 Oct 2002 11:57:39 -0400
Date: Wed, 23 Oct 2002 12:01:44 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Paul Larson <plars@linuxtestproject.org>
Cc: Frank Cornelis <fcorneli@elis.rug.ac.be>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] extended ptrace
Message-ID: <20021023160144.GA11558@nevyn.them.org>
Mail-Followup-To: Paul Larson <plars@linuxtestproject.org>,
	Frank Cornelis <fcorneli@elis.rug.ac.be>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210231656080.19811-100000@trappist.elis.rug.ac.be> <1035387198.3447.39.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035387198.3447.39.camel@plars>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 10:33:17AM -0500, Paul Larson wrote:
> On Wed, 2002-10-23 at 10:01, Frank Cornelis wrote:
> > Hi,
> > 
> > A new extended ptrace patch is available at:
> > 	http://www.elis.rug.ac.be/~fcorneli/downloads/devel/exptrace-0.3.1.patch.gz
> Do you (or anyone else) have any good tests for this, or even ptrace in
> general?  I'm working on some ptrace tests for LTP, but if someone
> already has something to contribute it would save me some time. :)

GDB and gdbserver get a good range of it; just pick a couple of the
standard tests (to avoid problems with all the GDB bugs the testsuite
turns up :).  I have some more precise tests but they're for
features that haven't been accepted yet.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
