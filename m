Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132483AbRBRCIT>; Sat, 17 Feb 2001 21:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132536AbRBRCIK>; Sat, 17 Feb 2001 21:08:10 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:59660 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132483AbRBRCHu>;
	Sat, 17 Feb 2001 21:07:50 -0500
Date: Sun, 18 Feb 2001 03:07:27 +0100
From: Frank de Lange <frank@unternet.org>
To: David <david@kalifornia.com>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        reiser@namesys.com
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks mozilla compile
Message-ID: <20010218030727.C13823@unternet.org>
In-Reply-To: <1217040000.982455419@tiny> <3A8F29C5.7000302@kalifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8F29C5.7000302@kalifornia.com>; from david@kalifornia.com on Sat, Feb 17, 2001 at 05:47:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2001 at 05:47:49PM -0800, David wrote:
> I can say "me too" for this.  I thought it was perhaps glibc or binutils 
> tho.  I only have reiserfs systems now so I don't have a basis for 
> comparison.
> 
> However I -can- say that I didn't experience this until I put glibc 
> 2.2.1 on my systems.  I do use an "approved" gcc, stock 2.95.2.
> 
> I wouldn't be so quick to pin it on reiserfs.

Well, I run glibc-2.2.1 as well, so that might be one of the factors
contributing to this. Then again, glibc-2.2.1 with ext2 does not cause any
problems whatsoever with mozilla. So it could be that reiserfs + glibc-2.2.1 is
a bad combination, question remains which of these two is the culprit (if not
both). Since glibc-2.2.2 is out, I will give that a try as well. Not tonight
though...

And no, I'm not running RedHat 7.x for those who might think so (and
automatically blame everything on it).

When did you switch to glibc-2.2.1? Were you running reiserfs before that?

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
