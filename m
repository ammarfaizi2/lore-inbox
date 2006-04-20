Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWDTRqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWDTRqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWDTRqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:46:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43683 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751116AbWDTRqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:46:08 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060420171922.GB21659@infradead.org> 
References: <20060420171922.GB21659@infradead.org>  <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165935.9968.11060.stgit@warthog.cambridge.redhat.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] FS-Cache: Export find_get_pages() 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 20 Apr 2006 18:45:50 +0100
Message-ID: <21746.1145555150@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > The attached patch exports find_get_pages() for use by the kAFS filesystem
> > in conjunction with it caching patch.
> 
> Why don't you use pagevec ?

You mean pagevec_lookup() I suppose... That's probably reasonable, though
slower.

David
