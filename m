Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbUKOMxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbUKOMxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 07:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbUKOMxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 07:53:16 -0500
Received: from verein.lst.de ([213.95.11.210]:21635 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261585AbUKOMxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 07:53:04 -0500
Date: Mon, 15 Nov 2004 13:52:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] appletalk Makefile
Message-ID: <20041115125253.GA18464@lst.de>
References: <200411151158.iAFBwi613920@apps.cwi.nl> <20041115120409.GA17703@lst.de> <20041115125105.GA14142@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115125105.GA14142@apps.cwi.nl>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 01:51:05PM +0100, Andries Brouwer wrote:
> On Mon, Nov 15, 2004 at 01:04:09PM +0100, Christoph Hellwig wrote:
> > On Mon, Nov 15, 2004 at 12:58:44PM +0100, Andries.Brouwer@cwi.nl wrote:
> > > There is no dev.c in net/appletalk.
> > 
> > Dave forgot to bk add it when I sent him the patch.  Here's what
> > should be dev.c:
> 
> Thanks!
> 
> (Looking why I did not need this, I see that ltalk_setup is referenced
> only by ltpc.c and cops.c. But it would be a bit messy to express this
> dependence.)

Depencies haven't changed from the previous state (when it was ifdef'ed
in drivers/net/net_init.c)

