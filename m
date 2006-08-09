Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWHIROK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWHIROK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWHIROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:14:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29655 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751169AbWHIROI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:14:08 -0400
Date: Wed, 9 Aug 2006 18:14:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 6/6] monitor zeroing of i_nlink
Message-ID: <20060809171405.GF7324@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060809165729.FE36B262@localhost.localdomain> <20060809165734.B81884DC@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809165734.B81884DC@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 09:57:34AM -0700, Dave Hansen wrote:
> 
> Some filesystems, instead of simply decrementing i_nlink, simply zero
> it during an unlink operation.  We need to catch these in addition
> to the decrement operations.
> 
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

Acked-by: Christoph Hellwig <hch@lst.de>


btw, what about adding some nice kerneldoc for all the *_nlink helpers
you added?

> ---
> 
>  kernel/fork.c                |    0 

something is screwed up in your diffstats :)

