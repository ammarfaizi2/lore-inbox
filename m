Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274750AbRIUEGg>; Fri, 21 Sep 2001 00:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274751AbRIUEG0>; Fri, 21 Sep 2001 00:06:26 -0400
Received: from [195.223.140.107] ([195.223.140.107]:46327 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274750AbRIUEGX>;
	Fri, 21 Sep 2001 00:06:23 -0400
Date: Fri, 21 Sep 2001 06:06:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010921060648.B729@athlon.random>
In-Reply-To: <20010921054749.Z729@athlon.random> <Pine.GSO.4.21.0109202350190.5631-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109202350190.5631-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Sep 21, 2001 at 12:00:35AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 12:00:35AM -0400, Alexander Viro wrote:
> Well, taking a file on ramfs and doing losetup on it should be equivalent
> to ramdisk.  Turning relevant pieces into a driver shouldn't be too hard.
> It won't be pretty, though - you'll probably want different
> address_space_operations, so that read()/write() wouldn't bother with
> requests at all.

My same idea, agreed.

Andrea
