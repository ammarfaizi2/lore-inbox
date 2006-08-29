Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWH2JCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWH2JCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWH2JCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:02:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751297AbWH2JCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:02:52 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060827212136.GA12710@tuatara.stupidest.org> 
References: <20060827212136.GA12710@tuatara.stupidest.org>  <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com> <20060825193709.11384.79794.stgit@warthog.cambridge.redhat.com> 
To: Chris Wedgwood <cw@f00f.org>
Cc: David Howells <dhowells@redhat.com>, axboe@kernel.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] [PATCH] BLOCK: Don't call block_sync_page() from AFS [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 10:00:31 +0100
Message-ID: <9824.1156842031@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:

> > The AFS filesystem specifies block_sync_page() as its sync_page
> > address op, which needs to be checked, and so is commented out for
> > the moment.
> 
> Wouldn't it be better to just let the link/build fail so someone who
> groks AFS internals can look into this?

That would be me...

I don't want the block patches getting rejected because make allyesconfig fails
due to AFS not linking.

David
