Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275203AbRIZODj>; Wed, 26 Sep 2001 10:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275208AbRIZOD3>; Wed, 26 Sep 2001 10:03:29 -0400
Received: from [195.223.140.107] ([195.223.140.107]:22525 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275207AbRIZODR>;
	Wed, 26 Sep 2001 10:03:17 -0400
Date: Wed, 26 Sep 2001 16:03:47 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)
Message-ID: <20010926160347.F27945@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109260617450.3929-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109260617450.3929-100000@loke.as.arizona.edu>; from ckulesa@as.arizona.edu on Wed, Sep 26, 2001 at 06:38:48AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 06:38:48AM -0700, Craig Kulesa wrote:
> in memory, and is swapping out harder to compensate.  The ac14/ac15 tree

2.4.10 is swapping out more also because I don't keep track of which
pages are just uptodate on the swap space. This will be fixed as soon as
I teach get_swap_page to collect away from the swapcache mapped
exclusive swap pages.

Andrea
