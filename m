Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269208AbUJQQ1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269208AbUJQQ1i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269207AbUJQQ1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:27:04 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3022 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269205AbUJQQOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:14:10 -0400
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
From: Lee Revell <rlrevell@joe-job.com>
To: Buddy Lucas <buddy.lucas@gmail.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <5d6b65750410170840c80c314@mail.gmail.com>
References: <20041016062512.GA17971@mark.mielke.cc>
	 <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
	 <20041017133537.GL7468@marowsky-bree.de>
	 <5d6b657504101707175aab0fcb@mail.gmail.com>
	 <20041017150509.GC10280@mark.mielke.cc>
	 <5d6b65750410170840c80c314@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1098029617.2148.56.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 12:13:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 11:40, Buddy Lucas wrote:
> > poorly wirtten. For blocking sockets, it makes select() useless as a
> > reliable mechanism for determining whether or not the recvmsg() will
> > block. I say useless, because I don't know why any professional
> 
> That use of select() *is* useless, there's no doubt about that. It is
> an application problem though.
> 

At this point it's a documentation problem.  It's clear that the
behavior is by design and is not changing.  It's also clear that this is
not the expected behavior for some people.  Can't we just note this in
CAVEATS or something and move on?

Lee



