Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbWHXTpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWHXTpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWHXTpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:45:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42909 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030468AbWHXTpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:45:32 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1156447974.5629.54.camel@localhost> 
References: <1156447974.5629.54.camel@localhost>  <1156432859.5629.24.camel@localhost> <32511.1156263593@warthog.cambridge.redhat.com> <7346.1156444521@warthog.cambridge.redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       aviro@redhat.com, steved@redhat.com, linux-kernel@vger.kernel.org,
       nfsv4@linux-nfs.org
Subject: Re: [PATCH] NFS: Check lengths more thoroughly in NFS4 readdir XDR decode 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 24 Aug 2006 20:45:08 +0100
Message-ID: <17073.1156448708@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> No. I find that mixture of < and <= is much less easy to read. Besides,
> the compiler should be able to optimise that for me.

So you don't think they're mathematically equivalent?

David
