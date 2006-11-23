Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757264AbWKWLrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264AbWKWLrq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757279AbWKWLrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:47:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4042 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757264AbWKWLrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:47:45 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061122132008.2691bd9d.akpm@osdl.org> 
References: <20061122132008.2691bd9d.akpm@osdl.org>  <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] WorkStruct: Shrink work_struct by two thirds 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 23 Nov 2006 11:44:33 +0000
Message-ID: <10937.1164282273@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > These patches shrink work_struct by 8 of the 12 words it ordinarily
> > consumes.
> 
> waaaaaaaay too many rejects for me, sorry.  This is quite the worst time in
> the kernel cycle to be preparing patches like this.  Especially when they're
> against mainline when everyone has so much material pending.
> 
> Please wait until 2.6.20-rc1, or prepare diffs against next -mm.

I'll wait till -rc1.

I could give you diffs against -mm, but I'm not sure it's help:-/  This sort
of blanket patch really needs to go underneath your patch queue rather than on
top of it, I think.

Of course, it all depends on whether Linus wants to take it at all...  Linus?

David
