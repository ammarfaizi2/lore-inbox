Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317175AbSFBMvo>; Sun, 2 Jun 2002 08:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317176AbSFBMvn>; Sun, 2 Jun 2002 08:51:43 -0400
Received: from maila.telia.com ([194.22.194.231]:1218 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S317175AbSFBMvn>;
	Sun, 2 Jun 2002 08:51:43 -0400
To: Thunder from the hill <thunder@ngforever.de>
Cc: Peter Osterlund <petero2@telia.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <Pine.LNX.4.44.0206020601320.29405-100000@hawkeye.luckynet.adm>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jun 2002 14:51:41 +0200
Message-ID: <m24rglhmhu.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill <thunder@ngforever.de> writes:

> Hi,
> 
> On 2 Jun 2002, Peter Osterlund wrote:
> > Yes, I realize this problem will go away automatically when support
> > for the old makefile system is removed. I just wanted to present my
> > complete list of problems with kbuild 2.5. Except for those three
> > issues, I don't see any advantages with the old makefile system.
> 
> Well, problem #1 (make TAGS) - what did you use it for?

To create a TAGS file for emacs, which makes navigating the source
tree a lot easier.

> Problem #2 (make NO_MAKEFILE_GEN) is a bit tricky with the new concept. 
> You may try to maintain it, but I wonder where you'll end up.

On my system I get 0.40s with NO_MAKEFILE_GEN compared to 3.41s
without, so my system is fast enough even without NO_MAKEFILE_GEN. I
just find it strange that the documentation says bug reports will be
ignored. If it breaks unintentionally in future kernels, fixing it
would probably not be too hard. Or are you planning to remove this
feature altogether?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
