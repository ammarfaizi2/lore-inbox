Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263060AbSJBMGB>; Wed, 2 Oct 2002 08:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263066AbSJBMGB>; Wed, 2 Oct 2002 08:06:01 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:13145 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S263060AbSJBMF7>;
	Wed, 2 Oct 2002 08:05:59 -0400
Date: Wed, 2 Oct 2002 14:11:27 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Message-ID: <20021002121127.GA19416@win.tue.nl>
References: <Pine.GSO.4.21.0210012037040.9782-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0210012007240.7688-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210012007240.7688-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 08:12:28PM -0700, Linus Torvalds wrote:

> There's also all the user-level interfaces for dev_t, and the disk layout 
> interfaces used by various filesystems.
> 
> We can easily make kdev_t be 32-bit, but without a 32-bit dev_t that 
> doesn't help much.

There is no real problem. You know I did this several times
and also sent patches at various points in time. Asking Google yields

	http://www.uwsg.iu.edu/hypermail/linux/kernel/0103.3/0038.html

as the first reference, and it has all relevant details and an example patch.

(There was a discussion about 32 vs 64 bits. Of course 64 is better
in all respects, but it is no longer feasible so today it must be 32.
Too bad.)

Andries
