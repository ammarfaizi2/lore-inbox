Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWBBXPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWBBXPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWBBXPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:15:24 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:48277 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751196AbWBBXPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:15:21 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Fri, 3 Feb 2006 00:12:08 +0100
User-Agent: KMail/1.9.1
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602021434.33660.rjw@sisk.pl> <200602030727.58153.nigel@suspend2.net>
In-Reply-To: <200602030727.58153.nigel@suspend2.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602030012.08606.rjw@sisk.pl>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 02 February 2006 22:27, Nigel Cunningham wrote:
> On Thursday 02 February 2006 23:34, Rafael J. Wysocki wrote:
> > > > First, your code introduces many changes in many parts of the kernel,
> > > > so to merge it you'll have to ask many people for acceptance.
> > >
> > > I really must work harder to get rid of that perception. It used to be
> > > the case, but isn't nowadays. Just about all of suspend2's changes are
> > > new files in kernel/power and include/<arch>/suspend2.h. The remainder
> > > are misc fixes, and enhancements like Christoph's todo list.
> >
> > Well, in your previous series of patches there are examples to the
> > contrary, like the changes to kthread_create() or workqueues.  They would
> > require an ack from the maintainers of that code, at least.
> 
> That's not Suspend2 itself, but rather improvements to the freezer that are 
> logically distinct and would be useful to swsusp too. That said, if the work 
> you guys have done in the last couple of days gets merged,

I hope so.

> perhaps I'll drop most of it and just do the bdev freezing instead of
> sys_syncing, at least to check reliability.

Well, I must admit I haven't read your bdevs-freezing patch, mostly due to
limited time, but in principle I'm not against it.

> > Also, you probably need some changes in the arch code.  If that is so, the
> > maintainers of relevant architectures should be asked.
> >
> > That already is "many".
> 
> No. I have a little cleaning up still to do there, but the current arch 
> specific patches are all: 1) adding suspend2.h; 2) old modifications that can 
> be cleaned up 3) the odd new routine (eg a page_is_ram function for amd64).

If that is so, fine.  As I said before, as far as I'm concerned both solutions
can coexist as long as they don't conflict.

Greetings,
Rafael

