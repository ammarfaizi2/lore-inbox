Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129910AbRBCBpd>; Fri, 2 Feb 2001 20:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130302AbRBCBpY>; Fri, 2 Feb 2001 20:45:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4366 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129910AbRBCBpG>;
	Fri, 2 Feb 2001 20:45:06 -0500
Date: Sat, 3 Feb 2001 02:44:40 +0100
From: Jens Axboe <axboe@suse.de>
To: "Anders S. Buch" <abuch@math.mit.edu>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: Bug report
Message-ID: <20010203024440.C2048@suse.de>
In-Reply-To: <Pine.GSO.4.31.0102011703540.23000-200000@fermat.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.31.0102011703540.23000-200000@fermat.mit.edu>; from abuch@math.mit.edu on Thu, Feb 01, 2001 at 05:09:51PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01 2001, Anders S. Buch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> It seems that the ide/cdrom/amd756 code can cause some bad lockups, at
> least on my system.  I have an Athlon 500 system running the 2.4.1 kernel
> with Redhat 6.1 + updated modutils, etc.

Have you tried disabling DMA on the atapi drive, not all do atapi
dma in an orderly fashion (yet)?

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
