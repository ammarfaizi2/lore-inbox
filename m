Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbUCXEfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 23:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbUCXEfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 23:35:31 -0500
Received: from thunk.org ([140.239.227.29]:40420 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262999AbUCXEf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 23:35:27 -0500
Date: Tue, 23 Mar 2004 23:35:22 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing files in bk trees?
Message-ID: <20040324043521.GA28169@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0403232140160.7713@debian> <pan.2004.03.24.02.50.16.373654@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.03.24.02.50.16.373654@triplehelix.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 06:50:16PM -0800, Joshua Kwan wrote:
> On Tue, 23 Mar 2004 21:41:46 -0500, ameer armaly wrote:
> > Hi all.
> > I got the latest kernel tree from linux.bkbits.net, and I try to make
> > config, and it complains about a missing zconf.tab.h.  However, it has
> > decrypted the other sccs files, but for some oodd reason it can't find
> > this particular one.  Suggestions would be appriciated.
> > Thanks,
> 
> you need to do 'bk -r get' in the root of your checkout

Better to do a "bk -r get -S", actually.  That way files that are
already checked out won't be created a second time.

					- Ted
