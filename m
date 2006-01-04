Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWADMS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWADMS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 07:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWADMS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 07:18:28 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:20684 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751768AbWADMS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 07:18:27 -0500
Date: Wed, 4 Jan 2006 07:18:06 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: mitch@sfgoth.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect remove_proc_entry
In-Reply-To: <20060104012105.64e0e5cf.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0601040716190.3052@gandalf.stny.rr.com>
References: <1135973075.6039.63.camel@localhost.localdomain>
 <1135978110.6039.81.camel@localhost.localdomain> <20051230215544.GI27284@gaz.sfgoth.com>
 <1135980542.6039.84.camel@localhost.localdomain> <1135981124.6039.90.camel@localhost.localdomain>
 <20060104012105.64e0e5cf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Jan 2006, Andrew Morton wrote:

> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > FYI, to make sure that this solves the problem, I'm removing my locking
> > in my kernel and using this instead.  It usually crashes in a day or
> > two, so I can say this works if it makes it three days.
> >
>
> I guess the lock_kernel() approach is the way to go.  Fixing a race and
> de-BKLing procfs are separate exercises...
>
> Did the patch work?
>

Sorry, I forgot to respond, because the test is still running ;)

So yes, it not only ran for three days, it ran for six. I just killed it.

-- Steve

