Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTJUV5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTJUV5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:57:35 -0400
Received: from thunk.org ([140.239.227.29]:15846 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263396AbTJUV5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:57:34 -0400
Date: Tue, 21 Oct 2003 17:53:46 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Valdis.Kletnieks@vt.edu
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results are in
Message-ID: <20031021215346.GA15109@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Valdis.Kletnieks@vt.edu,
	root@chaos.analogic.com, linux-kernel@vger.kernel.org
References: <175701c397e6$b36e5310$24ee4ca5@DIAMONDLX60> <20031021193128.GA18618@helium.inexs.com> <Pine.LNX.4.53.0310211558500.19942@chaos> <200310212021.h9LKLQK3009397@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310212021.h9LKLQK3009397@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.4i
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

On Tue, Oct 21, 2003 at 04:21:26PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 21 Oct 2003 16:05:15 EDT, "Richard B. Johnson" said:
> 
> > If the respondent wants them isolated into a "BADBLOCKS" file,
> > he can make a utility to do that. It's really quite easy because
> > you can raw-read disks under Linux, plus there is already
> > the `badblocks` program that will locate them.
> 
> Yes, it's trivially easy to figure out that block 193453 on /dev/hdb is bad.
> It's even not too bad to map that to an offset on /dev/hdb4.  Even if you're
> using LVM or DM to map stuff, it's still attackable.  But how do you guarantee
> that block 193453 gets allocated to your badblocks file and not to some other
> file that just tried to extend itself by 32K?

Read the e2fsck man page, and pay attention to the -c, -l, and -L
options....

						- Ted

