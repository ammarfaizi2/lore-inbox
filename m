Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWHOTVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWHOTVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWHOTVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:21:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19105 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965219AbWHOTVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:21:00 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060815114912.d8fa1512.akpm@osdl.org> 
References: <20060815114912.d8fa1512.akpm@osdl.org>  <20060815104813.7e3a0f98.akpm@osdl.org> <20060815065035.648be867.akpm@osdl.org> <20060814143110.f62bfb01.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <10791.1155580339@warthog.cambridge.redhat.com> <918.1155635513@warthog.cambridge.redhat.com> <29717.1155662998@warthog.cambridge.redhat.com> <6241.1155666920@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 20:20:38 +0100
Message-ID: <7174.1155669638@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > > SELinux: initialized (dev 0:15, type nfs), uses genfs_contexts
> > 
> > I wonder if this is something to do with it.
> 
> `echo 0 > /selinux/enforce' "fixes" it.

Interesting.........................

Looks like a need to find myself a new testbox - one that can cope with both
SELinux *and* udev.

I wonder what SELinux is doing...

David
