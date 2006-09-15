Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWIOT4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWIOT4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWIOT4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:56:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751645AbWIOT4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:56:30 -0400
Date: Fri, 15 Sep 2006 12:52:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: schwidefsky@de.ibm.com
Cc: torvalds@osdl.org, gregkh@suse.de, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Race condition in usermodehelper.
Message-Id: <20060915125245.63e395bb.akpm@osdl.org>
In-Reply-To: <1158340136.23993.25.camel@localhost>
References: <20060915104654.GA31548@skybase>
	<20060915092600.3046c511.akpm@osdl.org>
	<1158340136.23993.25.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 19:08:56 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Fri, 2006-09-15 at 09:26 -0700, Andrew Morton wrote:
> > > [patch] Race condition in usermodehelper.
> >
> > You mean three days work?
> 
> Unfortunately yes. You really have to hit the machine hard to provoke
> this oops. All I had to work with was a dump that showed me the content
> of the memory after it crashed.

Sigh.  Sorry.

> > If so, I owe you a big apology, because an identical patch has been in -mm
> > for over a month.  I guess I didn't appreciate its significance.
> 
> Well, I could have looked in -mm after the first suspicion that there is
> something wrong with the kernel module loader. It would have saved me 2
> of the 3 days.. will remember for the next debug session.

No, you have absolutely no reason to expect that an oops fix is languishing
in -mm when we're at -rc6.  I reviewed the patch, agreed with it, queued it
in the wrong place in the series file and promptly forgot about it.  That's
literally three seconds inattention here costing three days over there.  I hate
me.

At least I got to do it to someone else for once.  But three days!!
