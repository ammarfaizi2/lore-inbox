Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268217AbRHRVv4>; Sat, 18 Aug 2001 17:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268332AbRHRVvq>; Sat, 18 Aug 2001 17:51:46 -0400
Received: from fedex.is.co.za ([196.4.160.243]:63502 "EHLO fedex.is.co.za")
	by vger.kernel.org with ESMTP id <S268217AbRHRVvj>;
	Sat, 18 Aug 2001 17:51:39 -0400
Date: Sat, 18 Aug 2001 23:52:11 +0200
From: Dewet Diener <dewet@dewet.org>
To: Mike Black <mblack@csihq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 partition unmountable
Message-ID: <20010818235211.A24646@darkwing.flatlit.net>
In-Reply-To: <20010818030321.A11649@darkwing.flatlit.net> <018901c127d5$fadba320$b6562341@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <018901c127d5$fadba320$b6562341@cfl.rr.com>; from mblack@csihq.com on Sat, Aug 18, 2001 at 07:07:32AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2001 at 07:07:32AM -0400, Mike Black wrote:
> If I'm reading the files right it looks like:
> #define EXT3_FEATURE_INCOMPAT_COMPRESSION  0x0001
> 
> Did you compress the file system?
Not knowingly, no.  Is that a mount option?  I'm mounting them the 
same on both sides, so its rather strange...

> Do a "tune2fs -l /dev/hdc" and see what features are set.
Heh, not much more useful:

# tune2fs -l /dev/hdd1
tune2fs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
tune2fs: Filesystem has unsupported feature(s) while trying to open /dev/hdd1
Couldn't find valid filesystem superblock.

I'll probably have to take the drive back, and see if it now mounts
in the original system :-/

Dewet

-- 
Dewet Diener   linux-kernel@dewet.org     -o)
Systems Administrator     iTouch Labs     / \
Self-confessed geek and Linux fanatic    _\_v

SYN! ..... SYN! ACK! ..... ACK!
The mating call of the internet
