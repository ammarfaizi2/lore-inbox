Return-Path: <linux-kernel-owner+w=401wt.eu-S1760728AbWLHN64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760728AbWLHN64 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 08:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760729AbWLHN6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 08:58:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51979 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760728AbWLHN6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 08:58:54 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061208022259.GB11551@wotan.suse.de> 
References: <20061208022259.GB11551@wotan.suse.de>  <20061204144634.GA14383@wotan.suse.de> <20061204100607.GA20529@wotan.suse.de> <29183.1165236916@redhat.com> <25001.1165350982@redhat.com> 
To: Nick Piggin <npiggin@suse.de>
Cc: David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch][rfc] rwsem: generic rwsem 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 08 Dec 2006 13:58:42 +0000
Message-ID: <4548.1165586322@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:

> > Look at how the counter works in the XADD-based version.  That's the way
> > it is *because* I'm using XADD.  That's quite limiting.
> 
> Not really. ll/sc architectures "emulate" xadd the same as they would
> emulate a spinlock. There is nothing suboptimal about it.

Yes, really.  You've missed the point entirely.  Look at *how* the counter
*works*.

David
