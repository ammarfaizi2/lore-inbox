Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274683AbRIYXBi>; Tue, 25 Sep 2001 19:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274685AbRIYXB2>; Tue, 25 Sep 2001 19:01:28 -0400
Received: from [195.223.140.107] ([195.223.140.107]:49648 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274683AbRIYXBY>;
	Tue, 25 Sep 2001 19:01:24 -0400
Date: Wed, 26 Sep 2001 01:01:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Paul Larson <plars@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        =?iso-8859-1?Q?Jacek=5Biso-8859-2=5DPop=B3awski?= 
	<jpopl@interia.pl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010926010149.U8350@athlon.random>
In-Reply-To: <1001319223.4613.34.camel@plars.austin.ibm.com> <Pine.LNX.4.21.0109240933390.1593-100000@freak.distro.conectiva> <20010926000922.I8350@athlon.random> <E15m0Wz-0002He-00@mrvdom01.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E15m0Wz-0002He-00@mrvdom01.schlund.de>; from linux-kernel@borntraeger.net on Wed, Sep 26, 2001 at 12:16:53AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 12:16:53AM +0200, Christian Bornträger wrote:
> > too much permissive (vm-tweaks-1 does something similar but not that
> > permissive)
> 
> But it doesnt help neither.  I installed vm-tweaks-1 on a vanilla 2.4.10 and 
> still got an __alloc_pages: 0-order allocation failure
> I have no swap and 512 MB of RAM.

Could you enable CONFIG_DEBUG_GFP (kernel debugging menu) in 2.4.10aa1
and send me full traces of the faliures so I can better see where the
problem cames from? Thanks!

Andrea
