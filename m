Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbWCIAyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbWCIAyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWCIAyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:54:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932665AbWCIAyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:54:35 -0500
Date: Wed, 8 Mar 2006 16:54:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@redhat.com>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
In-Reply-To: <17423.30789.214209.462657@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0603081652430.32577@g5.osdl.org>
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
 <20060308184500.GA17716@devserv.devel.redhat.com>
 <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com>
 <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com>
 <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com>
 <14275.1141844922@warthog.cambridge.redhat.com> <19984.1141846302@warthog.cambridge.redhat.com>
 <17423.30789.214209.462657@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Mar 2006, Paul Mackerras wrote:
> 
> If you ask me, the need for mmiowb on some platforms merely shows that
> those platforms' implementations of spinlocks and read*/write* are
> buggy...

You could also state that same as

	"If you ask me, the need for mmiowb on some platforms merely shows 
	 that those platforms perform like a bat out of hell, and I think 
	 they should be slower"

because the fact is, x86 memory barrier rules are just about optimal for 
performance.

		Linus
