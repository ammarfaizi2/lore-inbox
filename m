Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbUAHAtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbUAHAtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:49:36 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:8202 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262795AbUAHAtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:49:35 -0500
Date: Thu, 8 Jan 2004 08:48:35 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Jim Carter <jimc@math.ucla.edu>
cc: Mike Waychison <Michael.Waychison@sun.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu>
Message-ID: <Pine.LNX.4.33.0401080846410.9294-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.5, required 8, AWL,
	BAYES_10, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Jim Carter wrote:

>
> > The exception to this rule is when the map entry for /home contains the
> > option 'browse':
>
> Solaris 2.6 and above has the -browse option on indirect maps, so the set
> of subdirs potentially mountable can be seen, without mounting them. I
> don't see where this is implemented in Linux, nor do I see how it's done,
> documented in Solaris NFS man pages, but I didn't put a lot of time into
> the search.  I *hope* rpc.mountd has an opcode to enumerate every
> filesystem it's willing to export.  Does it "stat" and return the stat
> data?  That would be important for "ls".

So, even after our most recent email conversation, you still haven't
checked out autofs 4.1.0 and my kernel module kit.


