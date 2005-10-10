Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbVJJTEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbVJJTEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVJJTEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:04:12 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:23977 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751111AbVJJTEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:04:11 -0400
Date: Mon, 10 Oct 2005 13:04:08 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/16] GFS: core fs
Message-ID: <20051010190408.GC12886@parisc-linux.org>
References: <20051010170954.GC22483@redhat.com> <20051010191057.GB7683@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010191057.GB7683@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 11:10:58PM +0400, Alexey Dobriyan wrote:
> On Mon, Oct 10, 2005 at 12:09:54PM -0500, David Teigland wrote:
> > +	mp = kzalloc(sizeof(struct metapath), GFP_KERNEL | __GFP_NOFAIL);
> 
> Not checked.

 * __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
 * cannot handle allocation failures.  
