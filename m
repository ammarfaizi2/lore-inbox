Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbUKOMvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUKOMvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 07:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUKOMvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 07:51:25 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8689 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261584AbUKOMvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 07:51:21 -0500
Date: Mon, 15 Nov 2004 13:51:05 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Christoph Hellwig <hch@lst.de>
Cc: Andries.Brouwer@cwi.nl, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] appletalk Makefile
Message-ID: <20041115125105.GA14142@apps.cwi.nl>
References: <200411151158.iAFBwi613920@apps.cwi.nl> <20041115120409.GA17703@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115120409.GA17703@lst.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 01:04:09PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 15, 2004 at 12:58:44PM +0100, Andries.Brouwer@cwi.nl wrote:
> > There is no dev.c in net/appletalk.
> 
> Dave forgot to bk add it when I sent him the patch.  Here's what
> should be dev.c:

Thanks!

(Looking why I did not need this, I see that ltalk_setup is referenced
only by ltpc.c and cops.c. But it would be a bit messy to express this
dependence.)

Andries
