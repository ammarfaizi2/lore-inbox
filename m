Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWEJQof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWEJQof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWEJQoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:44:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63181 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964925AbWEJQoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:44:34 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060510162342.GA18827@infradead.org> 
References: <20060510162342.GA18827@infradead.org>  <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com> <20060510160132.9058.35796.stgit@warthog.cambridge.redhat.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/14] NFS: Share NFS superblocks per-protocol per-server per-FSID [try #8] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 10 May 2006 17:44:25 +0100
Message-ID: <20161.1147279465@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> As last time a big fat "no fucking way" for the exports.

If you can't be polite you should be consigned to the porn spam bin.

> I already told you how to fix it by creating a common helper in the VFS last
> time.

Thanks for spotting that.  They're actually now unnecessary and so I've put up
try #9 with them removed.  The common helper idea is also no longer necessary
since I can't use VFS pathwalk now to find the NFS4 root FH.

David
