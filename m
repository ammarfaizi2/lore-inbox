Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131400AbQLZAhp>; Mon, 25 Dec 2000 19:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131401AbQLZAhf>; Mon, 25 Dec 2000 19:37:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35657 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131400AbQLZAhX>; Mon, 25 Dec 2000 19:37:23 -0500
Date: Tue, 26 Dec 2000 01:06:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@ns.caldera.de>, linux-kernel@vger.kernel.org,
        lvm-devel@sistina.com
Subject: Re: [PATCH] LVM includes userlevel headers
Message-ID: <20001226010647.A2468@athlon.random>
In-Reply-To: <20001225235333.A22731@caldera.de> <20001226003244.E25861@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001226003244.E25861@athlon.random>; from andrea@suse.de on Tue, Dec 26, 2000 at 12:32:44AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 26, 2000 at 12:32:44AM +0100, Andrea Arcangeli wrote:
> On Mon, Dec 25, 2000 at 11:53:33PM +0100, Christoph Hellwig wrote:
> > The first patch fixes that and the second changes the toplevel Makefile
> > to search only the kernel and gcc (for stdarg.h) includes to prevent such
> > accidents.
> 
> Looks fine, thanks.

BTW, I included your fixes into the 2.2.x backport (nostdinc in a separate
patch):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.19pre3aa2/14_bigmem-rawio-lvm-0.9-2.2.19pre3aa2-3.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.19pre3aa2/00_nostdinc-Christoph-Hellwig-1

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
