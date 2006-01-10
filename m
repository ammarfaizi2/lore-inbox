Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWAJRzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWAJRzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 12:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWAJRzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 12:55:16 -0500
Received: from mx.pathscale.com ([64.160.42.68]:33183 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932292AbWAJRzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 12:55:15 -0500
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Roland Dreier <rdreier@cisco.com>, sam@ravnborg.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060110175131.GA5235@infradead.org>
References: <patchbomb.1136579193@eng-12.pathscale.com>
	 <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
	 <20060110011844.7a4a1f90.akpm@osdl.org> <adaslrw3zfu.fsf@cisco.com>
	 <1136909276.32183.28.camel@serpentine.pathscale.com>
	 <20060110170722.GA3187@infradead.org>
	 <1136915386.6294.8.camel@serpentine.pathscale.com>
	 <20060110175131.GA5235@infradead.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 10 Jan 2006 09:55:14 -0800
Message-Id: <1136915714.6294.10.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 17:51 +0000, Christoph Hellwig wrote:

> This should be in the implementation file, not near the prototype.
> And needs to start with /** to be valid kernel doc.

OK, thanks.

> > +void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);
> 
> and without that comment I'd suggest just adding this to every asm/io.h
> instead of an asm-generic header for just one prototype.

OK, that header file will vanish.

	<b

