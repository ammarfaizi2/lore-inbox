Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUBIPVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 10:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUBIPVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 10:21:12 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:19209 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263851AbUBIPVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 10:21:10 -0500
Date: Mon, 9 Feb 2004 23:21:12 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
cc: =?koi8-r?Q?=22?=Kernel Mailing List=?koi8-r?Q?=22=20?= 
	<linux-kernel@vger.kernel.org>,
       =?koi8-r?Q?=22?=autofs mailing list=?koi8-r?Q?=22=20?= 
	<autofs@linux.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re[2]: [NFS] nfs or autofs related hangs
In-Reply-To: <E1AqCSz-0003v0-00.ia6432-inbox-ru@f23.mail.ru>
Message-ID: <Pine.LNX.4.58.0402092314180.5821@raven.themaw.net>
References: <E1AqCSz-0003v0-00.ia6432-inbox-ru@f23.mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004, [koi8-r] "Peter Lojkin[koi8-r] "  wrote:

> On Sun, 8 Feb 2004 at 23:32:08 +0800 Ian Kent wrote:
> 
> > Looking at the trace I can't tell if autofs v4 is causing this but
> > I believe there is a potential race in the wait queue code of the
> > autofs4 module.
> > 
> > Could you try this patch please.
> ok, i'll test it and let you know.
> but it may take up to several days or week...
> 

No problem.

The patch is against my 20031201 autofs4.
If you wish to test against a vanila kernel I'll need to revise it.

By the way, if you use the kernel module build kit you can 'make' the 
module, then 'make install', test and then 'make uninstall' to put the 
original module back. All you need is the source tree of the running 
kernel available (and macros set in Makefile.conf). I would need to make 
a different patch for this as well.

Ian

