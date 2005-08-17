Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVHQJUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVHQJUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 05:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVHQJUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 05:20:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44515 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751015AbVHQJUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 05:20:45 -0400
Date: Wed, 17 Aug 2005 10:20:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, kumar.gala@freescale.com, davem@davemloft.net,
       paulus@samba.org, galak@freescale.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, zach@vmware.com
Subject: Re: [PATCH] ppc32: removed usage of <asm/segment.h>
Message-ID: <20050817092041.GA12910@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, kumar.gala@freescale.com,
	davem@davemloft.net, paulus@samba.org, galak@freescale.com,
	akpm@osdl.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, zach@vmware.com
References: <20050816.203312.77701192.davem@davemloft.net> <032E6AED-9456-4271-9B06-C5DCE5970193@freescale.com> <20050817083048.GA11892@infradead.org> <E1E5Jii-0004Yc-00@dorka.pomaz.szeredi.hu> <20050817090920.GA12716@infradead.org> <E1E5K1L-0004bH-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E5K1L-0004bH-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 11:15:39AM +0200, Miklos Szeredi wrote:
> They are provided by _one_ kernel, not necessarily the running kernel.

No, they're provided by packages like glibc-kernheaders or similar
that are maintained separately.  They're split from the kernel headers
and we don't need to keep obsolete junk around.

