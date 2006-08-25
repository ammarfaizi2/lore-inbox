Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWHYQLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWHYQLZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 12:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWHYQLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 12:11:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422649AbWHYQLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 12:11:24 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060825141014.GD10659@infradead.org> 
References: <20060825141014.GD10659@infradead.org>  <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213258.21323.94502.stgit@warthog.cambridge.redhat.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] BLOCK: Stop fallback_migrate_page() from using page_has_buffers() [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 17:11:18 +0100
Message-ID: <9879.1156522278@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> Also if we ever get private data for anything but buffers these kinds of
> checks in generic code will cause problems.

Like NFS, for example.

David
