Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276527AbRJGSFv>; Sun, 7 Oct 2001 14:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276519AbRJGSFm>; Sun, 7 Oct 2001 14:05:42 -0400
Received: from [195.223.140.107] ([195.223.140.107]:37362 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276527AbRJGSFX>;
	Sun, 7 Oct 2001 14:05:23 -0400
Date: Sun, 7 Oct 2001 20:05:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.11-pre4 remove spurious kernel recompiles
Message-ID: <20011007200522.E726@athlon.random>
In-Reply-To: <23246.1002450342@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23246.1002450342@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sun, Oct 07, 2001 at 08:25:42PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 08:25:42PM +1000, Keith Owens wrote:
> in the top level Makefile forces a recompile of the entire kernel, for
> no good reason.

this is a matter of taste but personally I believe that at least
theorically recompiling the whole kernel if I add -g to CFLAGS, or if I
change the EXTRAVERSION have lots of sense. OTOH at the moment I
wouldn't trust the buildsystem anyways, so I'd run a `make distclean`
anyways in those cases :).

Andrea
