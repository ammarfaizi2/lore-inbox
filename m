Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbREWMGv>; Wed, 23 May 2001 08:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbREWMGm>; Wed, 23 May 2001 08:06:42 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:3171 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263064AbREWMGc>; Wed, 23 May 2001 08:06:32 -0400
Date: Wed, 23 May 2001 12:37:59 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Larry McVoy <lm@bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Getting FS access events
Message-ID: <20010523123759.G27177@redhat.com>
In-Reply-To: <200105140117.f4E1HqN07362@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.21.0105131824090.20981-100000@penguin.transmeta.com> <20010513184509.P2103@work.bitmover.com> <200105140239.f4E2dNd08399@vindaloo.ras.ucalgary.ca> <20010515163701.A13399@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010515163701.A13399@metastasis.f00f.org>; from cw@f00f.org on Tue, May 15, 2001 at 04:37:01PM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 15, 2001 at 04:37:01PM +1200, Chris Wedgwood wrote:
> On Sun, May 13, 2001 at 08:39:23PM -0600, Richard Gooch wrote:
> 
>     Yeah, we need a decent unfragmenter. We can do that now with
>     bmap().
> 
> SCT wrote a defragger for ext2 but it only handles 1k blocks :(

Actually, I wrote it for extfs, and Alexey Vovenko ported it to ext2.
Extfs *really* needed a defragmenter, because it had weird behaviour
patterns which included allocating all of the blocks of a file in
descending disk blocks at times.  

Cheers,
 Stephen
