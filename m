Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbWH2SFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWH2SFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWH2SFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:05:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965190AbWH2SFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:05:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060829175421.GS12257@kernel.dk> 
References: <20060829175421.GS12257@kernel.dk>  <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com> 
To: Jens Axboe <axboe@kernel.dk>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] BLOCK: Permit block layer to be disabled [try #5] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 19:05:37 +0100
Message-ID: <32587.1156874737@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> Any remaining changes? Looks fine to me, although I wonder why you did
> not kill the block_sync_page() completely in AFS. Christophs analysis
> looked correct to me.

Aargh!  Forgot to save the buffer.

Yes, I meant to kill it completely.

David
