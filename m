Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUJAPuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUJAPuo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 11:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUJAPuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 11:50:44 -0400
Received: from peabody.ximian.com ([130.57.169.10]:4810 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263818AbUJAPs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 11:48:29 -0400
Subject: Re: [patch] inotify: make user visible types portable
From: Robert Love <rml@novell.com>
To: Paul Jackson <pj@sgi.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20041001084009.6b33c1a1.pj@sgi.com>
References: <1096410792.4365.3.camel@vertex>
	 <1096583108.4203.86.camel@betsy.boston.ximian.com>
	 <20040930155704.16d71cec.pj@sgi.com> <1096608925.4803.2.camel@localhost>
	 <20040930234436.097e6dfe.pj@sgi.com> <1096616399.4803.26.camel@localhost>
	 <20041001084009.6b33c1a1.pj@sgi.com>
Content-Type: text/plain
Date: Fri, 01 Oct 2004 11:47:04 -0400
Message-Id: <1096645624.7676.18.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 08:40 -0700, Paul Jackson wrote:

> For now, I will remain in the alternative school that says the "other"
> way to keep the kernel and user interfaces aligned is to have two
> separate header files, one tuned for each space, using the human brain
> to keep them aligned, and keeping things simple enough that the brain
> can do so reliably.  I find that optimizing the human readability of
> this code is more valuable than automatable header sharing across the
> kernel-user boundary.  In some cases, such as RPC or CORBA, automatic
> header sharing is damn near essential, but not here.

I'm not disagreeing with this, at all.

Most distributions ship kernel headers that have somehow been sanitized.

The canonical structure is still the thing located in inotify.h, though,
whether or not it is 'kept aligned by the human brain' or used
wholesale.

The structure needs to be used exactly the same between the kernel and
the user.  We both agree to that, right?  It is user visible.

	Robert Love


