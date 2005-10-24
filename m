Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVJXPh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVJXPh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVJXPh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:37:28 -0400
Received: from silver.veritas.com ([143.127.12.111]:43287 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751100AbVJXPh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:37:27 -0400
Date: Mon, 24 Oct 2005 16:36:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: what happened to page_mkwrite? - was: Re: page_mkwrite seems
 broken
In-Reply-To: <1130167005.19518.35.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0510241625230.4112@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com>
 <1130167005.19518.35.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Oct 2005 15:37:23.0035 (UTC) FILETIME=[D3DE92B0:01C5D8B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2005, Anton Altaparmakov wrote:
> On Wed, 2005-02-09 at 14:28 +0000, Hugh Dickins wrote:
> > On Fri, 4 Feb 2005, Hugh Dickins wrote in another thread:
> > > Isn't this exactly what David Howells' page_mkwrite stuff in -mm's
> > > add-page-becoming-writable-notification.patch is designed for?
> > > 
> > > Though it looks a little broken to me as it stands (beyond the two
> > > fixup patches already there).  I've not found time to double-check
.....
> 
> What happened with page_mkwrite?  It seems to have disappeared both from
> -mm and generally from the face of the earth...

page_mkwrite??  No, never heard of it round here, you must be mistaken ;)

But seriously, Andrew dropped it from 2.6.13-rc5-mm1, for expedient reasons:
- Dropped cachefs and the cachefs-for-AFS patches.  These get in the way of
  memory management testing a bit, and they're being redone anyway.

So Andrew's 2.6.13-rc4-mm1 directory should contain its last public state
(by which time I'd fixed up those various things I'd found to be broken).

But David may have redone a lot since then, I don't know: he's the one
to ask.  (And I'm afraid I've done my best to make the old patch not
apply to current -mm.)

Hugh

> I am very interested in having such ability for ntfs...
> 
> Is anyone still working on this?  If not why not?  Did it prove
> impractical or ...?
> 
> If no-one is working on this anymore, where do I find the last "current"
> patch?
> 
> Thanks a lot in advance!
> 
> Best regards,
> 
>         Anton
