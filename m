Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275198AbRIZNti>; Wed, 26 Sep 2001 09:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275197AbRIZNt2>; Wed, 26 Sep 2001 09:49:28 -0400
Received: from [195.223.140.107] ([195.223.140.107]:13565 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275198AbRIZNtO>;
	Wed, 26 Sep 2001 09:49:14 -0400
Date: Wed, 26 Sep 2001 15:48:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Larson <plars@austin.ibm.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010926154832.E27945@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0109240933390.1593-100000@freak.distro.conectiva> <1001331342.4610.49.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1001331342.4610.49.camel@plars.austin.ibm.com>; from plars@austin.ibm.com on Mon, Sep 24, 2001 at 11:35:41AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 11:35:41AM +0000, Paul Larson wrote:
> 
> The patch helped for me, but there are still problems.  I was able to
> run all the way through LTP without it shutting anything down.  When I
> used one of the memory tests to chew up all the ram though, I noticed
> that VM was killing things it shouldn't have.  First thing to get killed
> was cron, then top, then it finally killed mtest01 (the memory test
> mentioned before).

can you reproduce anything wrong with vm-tweaks-2 applied to plain
2.4.10? I posted it to l-k a few minutes ago.

Andrea
