Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVJXP1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVJXP1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVJXP1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:27:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17856 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751090AbVJXP1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:27:10 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1130167005.19518.35.camel@imp.csi.cam.ac.uk> 
References: <1130167005.19518.35.camel@imp.csi.cam.ac.uk>  <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> 
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Hugh Dickins <hugh@veritas.com>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: what happened to page_mkwrite? - was: Re: page_mkwrite seems broken 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Mon, 24 Oct 2005 16:26:31 +0100
Message-ID: <7872.1130167591@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> What happened with page_mkwrite?  It seems to have disappeared both from
> -mm and generally from the face of the earth...

It got taken out because no one was using it (CacheFS has been removed
temorarily).

I'm still attempting to maintain it. If you want I can post it to Andrew again
to see if he'll take it back. If you want a direct copy, I'll have to extract
it from CacheFS.

David
