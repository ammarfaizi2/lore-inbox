Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264989AbRFZPar>; Tue, 26 Jun 2001 11:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264993AbRFZPah>; Tue, 26 Jun 2001 11:30:37 -0400
Received: from cmr0.ash.ops.us.uu.net ([198.5.241.38]:60818 "EHLO
	cmr0.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S264989AbRFZPaX>; Tue, 26 Jun 2001 11:30:23 -0400
Message-ID: <3B38A988.A576028B@uu.net>
Date: Tue, 26 Jun 2001 11:26:00 -0400
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: AMD thunderbird oops
In-Reply-To: <E15EuQn-0003eT-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's weird though is that it is rock solid as long as I don't use
athlon optimizations.  I'm not sure how much of a speed improvement they
provide, but everything's fine with i686, so I can't complain, besides I
doubt I can return the board at this point anyway.  BTW, which would be
better with an athlon, k6 or i686 optimization?  I've heard i686 is
faster, but I've never really looked into it too much myself.

Thanks,

Alex

Alan Cox wrote:
> 
> > I get oopses too when I use kernels compiled for athlon on my redhat
> > 7.1, athlon 850 system.  runs rock solid when I compile for i686.  I
> > assumed the athlon optimizations in the kernel were broken, or gcc's
> > athlon optimization was, as I seem to recall some discussion of this a
> > while back on the LKML.
> 
> Most IWILL K266 people report this. Those who swapped them for other boards
> mostly report the problem then going away. Yes it could be a bug we trigger
> that by chance the IWILL boards show up more than others but I'm sceptical
> 
> Alan
