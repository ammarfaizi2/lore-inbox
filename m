Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUJAPnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUJAPnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUJAPnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:43:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5542 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263769AbUJAPl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:41:59 -0400
Date: Fri, 1 Oct 2004 08:40:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Robert Love <rml@novell.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] inotify: make user visible types portable
Message-Id: <20041001084009.6b33c1a1.pj@sgi.com>
In-Reply-To: <1096616399.4803.26.camel@localhost>
References: <1096410792.4365.3.camel@vertex>
	<1096583108.4203.86.camel@betsy.boston.ximian.com>
	<20040930155704.16d71cec.pj@sgi.com>
	<1096608925.4803.2.camel@localhost>
	<20040930234436.097e6dfe.pj@sgi.com>
	<1096616399.4803.26.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert wrote:
> 
> but sharing a header (or at least generating
> user-space's version of the header from the kernel header) is the only
> way to ensure that both kernel and user-space speak the same language.

Ok - your understanding is clearly stated.  So be it.

For now, I will remain in the alternative school that says the "other"
way to keep the kernel and user interfaces aligned is to have two
separate header files, one tuned for each space, using the human brain
to keep them aligned, and keeping things simple enough that the brain
can do so reliably.  I find that optimizing the human readability of
this code is more valuable than automatable header sharing across the
kernel-user boundary.  In some cases, such as RPC or CORBA, automatic
header sharing is damn near essential, but not here.

I have no delusions of having sufficient standing in the community, or
confidence of my position, to cause you to change your understanding.

Good luck.  Thanks for replying.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
