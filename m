Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWHNSMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWHNSMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 14:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWHNSMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 14:12:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34489 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751499AbWHNSMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 14:12:34 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060814101657.8c5b796a.akpm@osdl.org> 
References: <20060814101657.8c5b796a.akpm@osdl.org>  <1155542805.3430.5.camel@raven.themaw.net> <20060813012454.f1d52189.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> <15771.1155547930@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>,
       linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 14 Aug 2006 19:12:23 +0100
Message-ID: <1871.1155579143@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> ?---------  ? ?    ?             ?            ? /net/bix/mnt
> ?---------  ? ?    ?             ?            ? /net/bix/usr

Do /mnt and /usr have other things mounted on them on bix?  Can you dump fstab
on bix?

If so, it's possible that the server-mountpoint-crossing automounter internal
to NFS doesn't like working with autofs.

David
