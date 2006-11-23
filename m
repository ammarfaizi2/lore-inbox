Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757464AbWKWUkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464AbWKWUkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757465AbWKWUkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:40:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:3262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757464AbWKWUkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:40:40 -0500
Date: Thu, 23 Nov 2006 13:40:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] WorkStruct: Shrink work_struct by two thirds
Message-Id: <20061123134011.bfbe51a9.akpm@osdl.org>
In-Reply-To: <20447.1164312071@redhat.com>
References: <Pine.LNX.4.64.0611230920230.27596@woody.osdl.org>
	<20061122132008.2691bd9d.akpm@osdl.org>
	<20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>
	<10937.1164282273@redhat.com>
	<20447.1164312071@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 20:01:11 +0000
David Howells <dhowells@redhat.com> wrote:

> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > I obviously didn't see how nasty the conflicts were, and I would want it 
> > to be not too painful for Andrew. So I could either take it early after 
> > 2.6.19 _or_ after Andrew has merged the bulk of his stuff, depending on 
> > which way is easier.
> 
> Perhaps if Andrew gives me an estimate of what patches he's going to commit
> this time around, I can use those as a base for my patch.
> 

Most of the outstanding work is in git trees, so I don't know.

Just merge it late in merge window - we'll work it out.

But please make sure it's all done this time.  ie: use grep.  Heaps of simple
stuff got missed in the pt_regs conversion.  
