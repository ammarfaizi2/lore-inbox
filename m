Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWBDQh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWBDQh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWBDQh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:37:57 -0500
Received: from dvhart.com ([64.146.134.43]:20886 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932359AbWBDQh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:37:56 -0500
Date: Sat, 4 Feb 2006 08:37:52 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
To: Marc Koschewski <marc@osknowledge.org>
Cc: dtor_core@ameritech.net, rlrevell@joe-job.com, 76306.1226@compuserve.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Wanted: hotfixes for -mm kernels
Message-Id: <20060204083752.a5c5b058.mbligh@mbligh.org>
In-Reply-To: <20060203100703.GA5691@stiffy.osknowledge.org>
References: <200602021502_MC3-1-B772-547@compuserve.com>
	<1138913633.15691.109.camel@mindpipe>
	<d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com>
	<20060203100703.GA5691@stiffy.osknowledge.org>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I doubt it - mm is an experimental kernel, hotfixes only make sense for
> > > production stuff.  It moves too fast.
> > >
> > > A better question is what does -mm give you that mainline does not, that
> > > causes you to want to "stabilize" a specific -mm version?
> > >
> > 
> > Some people just run -mm so the hotfixes/* would help them to get
> > their boxes running until the next -mm without having to hunt through
> > LKML for bugs already reported/fixed. This will allow better testing
> > coverage because most obvious bugs are caught almost immediately and
> > then people can continue using -mm to find more stuff.
> 
> ... that's just why I so often wish to have a -git tree, Andrew. ;)

Why do people always thing a source code control system is magically going
to fix all bugs and wipe their ass for them?

You still have to work out which patches are relevant and merge them. If 
he's just merging a new set of changes constantly, it won't help you a damn. 

What is needed is somebody to do the grunt work, not SCM magic. I'll try to
help with Randy's suggestion of a shared pool of patches in a common dumping 
ground at least - I've needed pretty much the same thing in the past for the 
test.kernel.org stuff ... mainly fixups needed to get the tree to boot so
we can test it.

M.
