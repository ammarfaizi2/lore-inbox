Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWHYSq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWHYSq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWHYSq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:46:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964917AbWHYSq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:46:28 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <10117.1156522985@warthog.cambridge.redhat.com> 
References: <10117.1156522985@warthog.cambridge.redhat.com>  <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 19:46:23 +0100
Message-ID: <10409.1156531583@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > Can you put this two into a single ifdef block?
> 
> I suppose it could make sense to move the two disk random source functions
> together.

I don't think I should.  drivers/char/random.c seems to be carefully laid out
with similar functions grouped together under grouping banners.

David
