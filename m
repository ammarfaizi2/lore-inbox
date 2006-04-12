Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWDLST3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWDLST3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 14:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWDLST3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 14:19:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41138 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932309AbWDLST2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 14:19:28 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1144864128.8056.8.camel@lade.trondhjem.org> 
References: <1144864128.8056.8.camel@lade.trondhjem.org>  <20060411150512.5dd6e83d.akpm@osdl.org> <16476.1144773375@warthog.cambridge.redhat.com> <17771.1144839377@warthog.cambridge.redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use atomic ops for file_nr accounting, not spinlock+irq 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 12 Apr 2006 19:19:18 +0100
Message-ID: <18424.1144865958@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> I've been updating the NFS git tree on a daily basis. I'm not going to
> begin pulling from the -mm tree, though.

The thing to which I refer is in Linus's tree but wasn't in yours this
morning.  Unfortunately, this means my patch has to be different, depending on
whose tree I'm using... although your tree has been updated since then, so the
difference seems to have gone away.

I don't mean to be critical of your efforts, but the requirement imposed by
Andrew that I have to base my tree on yours makes things a little tricky
sometimes:-/

David
