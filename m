Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319032AbSHFJkG>; Tue, 6 Aug 2002 05:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319033AbSHFJkG>; Tue, 6 Aug 2002 05:40:06 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:27144 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319032AbSHFJkG>; Tue, 6 Aug 2002 05:40:06 -0400
Date: Tue, 6 Aug 2002 10:43:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: arnd@bergmann-dalldorf.de
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] 15/18 better pte invalidation
Message-ID: <20020806104342.A16600@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	arnd@bergmann-dalldorf.de,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <200208051830.50713.arndb@de.ibm.com> <200208051954.55546.arndb@de.ibm.com> <20020805180103.A16035@infradead.org> <200208061305.17296.arndb@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208061305.17296.arndb@de.ibm.com>; from arndb@de.ibm.com on Tue, Aug 06, 2002 at 01:05:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 01:05:17PM +0200, Arnd Bergmann wrote:
> > Otherwise please try to get all this in 2.5 first, it's a major VM change.
> Right. I guess this one falls more in the category "If anyone wants to build
> an s390 2.4.19 kernel, use this patch, because it's what we have tested at 
> IBM".

Umm.  2.4.19 _does_ build on S/390.  By getting in a truckload of patches
that update everything to IBM's latest & greatest that just require a few
unacceptable / not yet acceptable intrusive core changes you break that.

You probably don't care a lot, but people trying to test S/390 compatiblity
on Hercules (or a Multiprise in the basement..) really want to compile
kernels out-of-the-box.

