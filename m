Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbUBPBMH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 20:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUBPBMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 20:12:07 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:18705 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S265277AbUBPBME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 20:12:04 -0500
Date: Mon, 16 Feb 2004 09:13:55 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Rusty Russell <rusty@rustcorp.com.au>
cc: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] nfs or autofs related hangs 
In-Reply-To: <20040215222107.7E4382C2D8@lists.samba.org>
Message-ID: <Pine.LNX.4.58.0402160910300.28358@wombat.indigo.net.au>
References: <20040215222107.7E4382C2D8@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net> you write:
> > +static spinlock_t waitq_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
> 
> Is this __cacheline_aligned_in_smp really required?
> 

I must admit I put this together without much thought with a "cut and 
paste".

But, please tell me. I'm not entirely clear on what conditions I 
should be concerned about blowing the cache.

Ian

