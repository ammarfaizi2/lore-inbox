Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312212AbSCTVjY>; Wed, 20 Mar 2002 16:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312233AbSCTVjG>; Wed, 20 Mar 2002 16:39:06 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:56932 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312212AbSCTVix>; Wed, 20 Mar 2002 16:38:53 -0500
Date: Wed, 20 Mar 2002 22:38:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <20020320223826.Q4268@dualathlon.random>
In-Reply-To: <20020320203520.A2003@infradead.org> <Pine.LNX.4.21.0203202109020.1721-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 09:17:31PM +0000, Hugh Dickins wrote:
> probably above user stack, since that's already of indefinite size.

yes, that's the only place where it would be sane to put it.

Andrea
