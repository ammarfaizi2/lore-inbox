Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274709AbRIYXT2>; Tue, 25 Sep 2001 19:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274710AbRIYXTS>; Tue, 25 Sep 2001 19:19:18 -0400
Received: from [195.223.140.107] ([195.223.140.107]:59888 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274709AbRIYXTO>;
	Tue, 25 Sep 2001 19:19:14 -0400
Date: Wed, 26 Sep 2001 01:19:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010926011955.O1782@athlon.random>
In-Reply-To: <1001319223.4613.34.camel@plars.austin.ibm.com> <E15m0Wz-0002He-00@mrvdom01.schlund.de> <20010926010149.U8350@athlon.random> <E15m1MU-0008OQ-00@mrvdom00.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E15m1MU-0008OQ-00@mrvdom00.schlund.de>; from linux-kernel@borntraeger.net on Wed, Sep 26, 2001 at 01:10:07AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 01:10:07AM +0200, Christian Bornträger wrote:
> > Could you enable CONFIG_DEBUG_GFP (kernel debugging menu) in 2.4.10aa1
> > and send me full traces of the faliures so I can better see where the
> > problem cames from? Thanks!
> >
> > Andrea
> 
> Is it enough, to take a vanilla 2.4.10 and apply 00_debug-gfp-1 and 
> 00_vm-tweaks-1 or should I patch to a complete aa1. If yes, where can I find 

yes, that's enough, you don't need the complete aa1 just for that.

> the complete aa1-Patch in one part?

The whole aa1 patch can be found in the v2.4 directory called as
2.4.10aa1.bz2.

Andrea
