Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269919AbRHEF0m>; Sun, 5 Aug 2001 01:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269920AbRHEF0d>; Sun, 5 Aug 2001 01:26:33 -0400
Received: from weta.f00f.org ([203.167.249.89]:24208 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269919AbRHEF00>;
	Sun, 5 Aug 2001 01:26:26 -0400
Date: Sun, 5 Aug 2001 17:27:18 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3/reiserfs: ext3fine, reiser got OOPS!
Message-ID: <20010805172718.B20716@weta.f00f.org>
In-Reply-To: <3B6CAE4E.17850717@pcsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B6CAE4E.17850717@pcsystems.de>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 04:24:14AM +0200, Nico Schottelius wrote:

    I 've been using ext3 and reiserfs for somedays with 2.4.7. Using
    mkreiserfs I recieved some null pointer problems and recieved a
    kernel oops.

Odd --- nobody else has reported this.  Can you plese supply more
details (ksymoops) such that these bugs may be fixed.

    While ext3 is mounted as fast as ext2, reiserfs seems is slower.

Slower to mount? Or slower to use?

    ext3, 10 GB: ~ 0.5 seconds reisferfs 10 GB: ~ 3-5 seconds

Probably journal replay, still, you might have slow disks.  A journal
reply for me of 60+ events takes about 1 second on a single spindle
(SCSI, U160).

    Generating the journal with tune2fs was again much faster than
    mkreiserfs. But I think this is because reiser creates a new fs,
    wherefore mkfs.ext2 did that before.

Yes.


Do it really matter (within reason) which fs mounts and is made
faster?  It's not something you do every other minute.



    While running there occured some problems with reiserfs.

Such as?

    I am wondering that reiserfs first got into the kernel before
    ext3!

It was ready first (mostly).





   --cw
