Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbTESJuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 05:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTESJuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 05:50:16 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:17681 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261408AbTESJuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 05:50:15 -0400
Date: Mon, 19 May 2003 11:03:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] futex-fixes-2.5.69-A0
Message-ID: <20030519110308.A8663@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <Pine.LNX.4.44.0305191054350.5302-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305191054350.5302-100000@localhost.localdomain>; from mingo@elte.hu on Mon, May 19, 2003 at 10:58:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 10:58:56AM +0200, Ingo Molnar wrote:
> +static inline
> +struct page *__pin_page_atomic (struct page *page)

Please fix the indentation.  Documentation/CondingStyle sais:

static inline struct page *__pin_page_atomic(struct page *page)

many people like

static inline struct page *
__pin_page_atomic(struct page *page)

but this is just crap.

