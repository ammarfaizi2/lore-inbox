Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWFJNv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWFJNv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 09:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWFJNv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 09:51:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15239 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030388AbWFJNv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 09:51:57 -0400
Date: Sat, 10 Jun 2006 14:51:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Mike Snitzer <snitzer@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610135122.GA9039@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Mike Snitzer <snitzer@gmail.com>,
	Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
	linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	cmm@us.ibm.com, linux-kernel@vger.kernel.org
References: <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org> <4489B452.4050100@garzik.org> <4489B719.2070707@garzik.org> <170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com> <20060610134946.GC11634@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610134946.GC11634@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 03:49:46PM +0200, Adrian Bunk wrote:
> > And no real-world near-term progress is made for production users with
> > modern requirements. What you're advocating breeds instability in the
> > near-term.
> 
> There's also the old-fashioned "no regressions" requirement.
> 
> You are trading near-term instability for the few users with "modern 
> requirements" against possible regressions for a large userbase.

Alex mentioned a few times that the extents code just adds three if.
I'm pretty sure that will not give you any regressions in the existing
codebase.  Can we concentrate on the more useful discussion topics now?

