Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265571AbSKADwd>; Thu, 31 Oct 2002 22:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265575AbSKADwc>; Thu, 31 Oct 2002 22:52:32 -0500
Received: from dp.samba.org ([66.70.73.150]:65202 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265571AbSKADwc>;
	Thu, 31 Oct 2002 22:52:32 -0500
Date: Fri, 1 Nov 2002 13:21:14 +1100
From: Anton Blanchard <anton@samba.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [rfc][patch] MAX_NR_NODES vs. MAX_NUMNODES
Message-ID: <20021101022114.GA728@krispykreme>
References: <3DB8927E.5090909@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB8927E.5090909@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matt,

> This patch
> 1) Gets rid of the include/asm-xxx/numnodes.h files
> 2) Defines MAX_NR_NODES to the appropriate per-arch value in 
> include/asm-xxx/param.h
> 3) changes all remaining occurences MAX_NUMNODES to MAX_NR_NODES 
> throughout the kernel

Looks good for ppc64.

Anton (using 20 hours of flights trying to catch up on email)
