Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVHQIay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVHQIay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 04:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVHQIay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 04:30:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41945 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750980AbVHQIax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 04:30:53 -0400
Date: Wed, 17 Aug 2005 09:30:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>,
       "Gala Kumar K.-galak" <galak@freescale.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
Message-ID: <20050817083048.GA11892@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Mackerras <paulus@samba.org>,
	"Gala Kumar K.-galak" <galak@freescale.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Zachary Amsden <zach@vmware.com>
References: <20050816.203312.77701192.davem@davemloft.net> <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 12:43:37AM -0500, Kumar Gala wrote:
> >I concur, in fact we should really kill that thing off entirely.
> 
> I'm all for killing it off entirely but got some feedback that on  
> i386 segment.h can be included by userspace programs.

No kernel headers can be included by userland anymore.

