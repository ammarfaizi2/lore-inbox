Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136593AbREEDS2>; Fri, 4 May 2001 23:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136589AbREEDST>; Fri, 4 May 2001 23:18:19 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:36880 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S136588AbREEDSO>; Fri, 4 May 2001 23:18:14 -0400
Date: Sat, 5 May 2001 15:18:08 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010505151808.A29451@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.21.0105031017460.30346-100000@penguin.transmeta.com> <200105041140.NAA03391@cave.bitwizard.nl> <20010504135614.S16507@suse.de> <20010504172940.U3762@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010504172940.U3762@athlon.random>; from andrea@suse.de on Fri, May 04, 2001 at 05:29:40PM +0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 05:29:40PM +0200, Andrea Arcangeli wrote:

    once block_dev is in pagecache there will obviously be no-way to
    share cache between the block device and the filesystem, because
    all the caches will be in completly different address spaces.

Once we are at this point... will there be any use in having block
devices? FreeBSD appears to have done without them completely about a
year ago (an observation, not a comment on whether this is a good
idea or not).



  --cw
