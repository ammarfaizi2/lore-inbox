Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132395AbREFDcs>; Sat, 5 May 2001 23:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbREFDcj>; Sat, 5 May 2001 23:32:39 -0400
Received: from [203.167.188.69] ([203.167.188.69]:7111 "HELO tapu")
	by vger.kernel.org with SMTP id <S132395AbREFDcd>;
	Sat, 5 May 2001 23:32:33 -0400
Date: Sun, 6 May 2001 15:32:18 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, Jens Axboe <axboe@suse.de>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010506153218.A11911@tapu.f00f.org>
In-Reply-To: <20010506150058.A31393@metastasis.f00f.org> <Pine.GSO.4.21.0105052313040.26799-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.GSO.4.21.0105052313040.26799-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, May 05, 2001 at 11:15:47PM -0400
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    It's not exactly "kernel-based fsck". What I've been talking about
    is secondary filesystem providing coherent access to primary fs
    metadata.  I.e. mount -t ext2meta -o master=/usr none /mnt and
    then access through /mnt/super, /mnt/block_bitmap, etc.

Call me stupid --- but what exactly does the above actually achieve?
Why would you do this?



  --cw
