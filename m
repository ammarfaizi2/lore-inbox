Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263970AbRFRN4k>; Mon, 18 Jun 2001 09:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263987AbRFRN4a>; Mon, 18 Jun 2001 09:56:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:10043 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263970AbRFRN4K>; Mon, 18 Jun 2001 09:56:10 -0400
Date: Mon, 18 Jun 2001 15:56:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: German Gomez Garcia <german@piraos.com>,
        Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour of swap under 2.4.5-ac15
Message-ID: <20010618155605.D13836@athlon.random>
In-Reply-To: <20010618143559.A23006@athlon.random> <Pine.LNX.4.21.0106181041470.2056-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0106181041470.2056-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Mon, Jun 18, 2001 at 10:43:14AM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2001 at 10:43:14AM -0300, Rik van Riel wrote:
> On Mon, 18 Jun 2001, Andrea Arcangeli wrote:
> 
> > either apply this patch to 2.4.5ac15:
> > 
> > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa3/00_fix-unusable-vm-on-alpha-1
> 
> That one has already been fixed in -pre3 and I think also

wrong, I merged it with Linus in pre2 not pre3.

> in -ac14+ kernels (haven't verified the -ac kernels, though).

wrong -ac15 is still missing it.

> which is now a lot closer to being balanced. It's not a bug,

wrong, that was a core showstopper bug and it renders any machine with a
zone empty unusable. (it has nothing to do with beauty or stats)

Andrea
