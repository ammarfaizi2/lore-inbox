Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274920AbRIXTum>; Mon, 24 Sep 2001 15:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274921AbRIXTuY>; Mon, 24 Sep 2001 15:50:24 -0400
Received: from pc-62-30-67-185-az.blueyonder.co.uk ([62.30.67.185]:26606 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S274920AbRIXTuD>; Mon, 24 Sep 2001 15:50:03 -0400
Date: Mon, 24 Sep 2001 20:49:46 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10 + ext3
Message-ID: <20010924204946.C9688@kushida.jlokier.co.uk>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com>, <9om4ed$1hv$1@penguin.transmeta.com> <20010923193008.A13982@vitelus.com> <3BAEAC52.677C064C@zip.com.au>, <3BAEAC52.677C064C@zip.com.au> <20010923214507.A15014@vitelus.com> <3BAEC254.2A29B495@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAEC254.2A29B495@zip.com.au>; from akpm@zip.com.au on Sun, Sep 23, 2001 at 10:19:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> And the main reason for having the same on-disk format is not, IMO, to
> ease migration between the two filesystems.  That's just a once-off
> activity.

I disagree that it's a once-off activity.  I've been known to switch
between ext2 and ext3 and ext2 and ext3...  just so I can boot old
kernels such as rescue disks.  It's nice to be able to do this.

Also I don't think resize2fs resizes the journal (but I may be wrong),
so I've converted ext3 to ext2 to resize a filesystem, then converted
back.

I did have a big disaster once when I compiled ext3 into a kernel and
not ext2 (which I left as a module).  You can guess, it couldn't mount
the root filesystem.

-- Jamie
