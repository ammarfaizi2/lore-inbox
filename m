Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWEEOxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWEEOxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWEEOxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:53:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50851 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751128AbWEEOxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:53:11 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1146839690.10108.21.camel@kleikamp.austin.ibm.com> 
References: <1146839690.10108.21.camel@kleikamp.austin.ibm.com>  <1146834740.10109.9.camel@kleikamp.austin.ibm.com> <84144f020605040737k316fd5abva4476da69a65c084@mail.gmail.com> <20060504031755.GA28257@hellewell.homeip.net> <20060504033829.GE28613@hellewell.homeip.net> <23457.1146778849@warthog.cambridge.redhat.com> <3439.1146837829@warthog.cambridge.redhat.com> 
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 05 May 2006 15:52:37 +0100
Message-ID: <9519.1146840757@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> wrote:

> > Either way, it will use more stack; the mere fact that whilst it's using the
> > value, the compiler may stash it in a register is irrelevant.
> 
> Is the stack usage very close to exceeding 4 KB?  Could saving one more
> pointer on the stack cause a problem?

I suspect you don't know since it's a stacked filesystem.

David
