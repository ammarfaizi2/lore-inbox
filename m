Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbRFRNga>; Mon, 18 Jun 2001 09:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263945AbRFRNgU>; Mon, 18 Jun 2001 09:36:20 -0400
Received: from quasar.osc.edu ([192.148.249.15]:48593 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S263944AbRFRNgE>;
	Mon, 18 Jun 2001 09:36:04 -0400
Date: Mon, 18 Jun 2001 09:35:46 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [docPATCH] mm.h documentation
Message-ID: <20010618093546.A9415@osc.edu>
In-Reply-To: <Pine.LNX.4.33.0106162309010.17512-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106162309010.17512-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sat, Jun 16, 2001 at 11:12:19PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

riel@conectiva.com.br said:
>  typedef struct page {
[..]
> +	unsigned long index;		/* Our offset within mapping. */

[..]
> + * A page may belong to an inode's memory mapping. In this case,
> + * page->mapping is the pointer to the inode, and page->offset is the
> + * file offset of the page (not necessarily a multiple of PAGE_SIZE).

Minor nit.

The field offset was renamed to index some time ago, but I can't
figure out if the usage changed.  Can you fix the comment and educate
us?

		-- Pete
