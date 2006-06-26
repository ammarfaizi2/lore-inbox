Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933009AbWFZUMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009AbWFZUMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933011AbWFZUMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:12:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10432 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933009AbWFZUMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:12:34 -0400
Subject: Re: GFS2 and DLM
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060626200300.GA15424@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <20060623144928.GA32694@infradead.org>  <20060626200300.GA15424@elte.hu>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 22:12:29 +0200
Message-Id: <1151352749.3185.78.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 22:03 +0200, Ingo Molnar wrote:
> * Christoph Hellwig <hch@infradead.org> wrote:
> 
> > The code uses GFP_NOFAIL for slab allocator calls.  It's been pointed 
> > out here numerous times that this can't work.  Andrew, what about 
> > adding a check to slab.c to bail out if someone passes it?
> 
> reiserfs, jbd and NTFS are all using GFP_NOFAIL ...
> 

they use it for slab or for get_free_pages() ?


