Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318718AbSHEQ5a>; Mon, 5 Aug 2002 12:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318720AbSHEQ5a>; Mon, 5 Aug 2002 12:57:30 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:38660 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318718AbSHEQ53>; Mon, 5 Aug 2002 12:57:29 -0400
Date: Mon, 5 Aug 2002 18:01:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: arnd@bergmann-dalldorf.de
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 15/18 better pte invalidation
Message-ID: <20020805180103.A16035@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	arnd@bergmann-dalldorf.de,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <200208051830.50713.arndb@de.ibm.com> <200208051954.55546.arndb@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208051954.55546.arndb@de.ibm.com>; from arndb@de.ibm.com on Mon, Aug 05, 2002 at 07:54:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 07:54:55PM +0200, Arnd Bergmann wrote:
> This is a patch that changes the memory management to allow s390/s390x to
> make best use of its memory subsystem. There are three problems:

Implementation comment: make pgd_populate return something on all
architectures, not just on s390.

Otherwise please try to get all this in 2.5 first, it's a major VM change.

