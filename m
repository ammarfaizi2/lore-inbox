Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVKEEgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVKEEgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 23:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVKEEgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 23:36:24 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:14094 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751174AbVKEEgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 23:36:24 -0500
Date: Fri, 4 Nov 2005 23:35:30 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export ia64_max_cacheline_size
Message-ID: <20051105043527.GC21567@tuxdriver.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>, davej@redhat.com,
	linux-kernel@vger.kernel.org
References: <20051104220737.GA16551@redhat.com> <20051104223441.GA16285@infradead.org> <20051104145534.17e913f2.akpm@osdl.org> <20051104235257.GA21674@infradead.org> <20051104160540.486051ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104160540.486051ed.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 04:05:40PM -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:

> > It's an API used only in slow pathes.  It's much better to enforce modularity
> > in that case.
> 
> hm, spose so.  Putting it into .c means that all arches except one
> implement it under include/, which is also a bit irritating sometimes, such
> as $EDITOR include/asm-*/dma-mapping.h.
> 
> It's a 51%/49% decision, but I'm not sure which way.

I posted a patch for this mid-September.  (Actually, I posted two.
The first one was basically identical to davej's, and Christoph
disliked it... :-)

	http://marc.theaimsgroup.com/?l=linux-kernel&m=112657055513967&w=2

I had hoped that it would get mainlined well before the b44 patch,
but apparently it fell through the cracks.  The patch still applies,
so I'll follow-up with it after this message.

John
-- 
John W. Linville
linville@tuxdriver.com
