Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280450AbRKODEb>; Wed, 14 Nov 2001 22:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280480AbRKODEV>; Wed, 14 Nov 2001 22:04:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21626 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280450AbRKODEF>; Wed, 14 Nov 2001 22:04:05 -0500
Date: Thu, 15 Nov 2001 04:03:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Terje Eggestad <terje.eggestad@scali.no>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: O_DIRECT broken in stock 2.4.13
Message-ID: <20011115040352.V1381@athlon.random>
In-Reply-To: <1005747508.1310.3.camel@pc-16.office.scali.no> <20011114125048.A32600@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011114125048.A32600@figure1.int.wirex.com>; from chris@wirex.com on Wed, Nov 14, 2001 at 12:50:48PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 12:50:48PM -0800, Chris Wright wrote:
> * Terje Eggestad (terje.eggestad@scali.no) wrote:
> > Hi 
> > 
> > open( , O_DIRECT) succeds, fcntl set and unset of the O_DIRECT flag is
> > ok, but I get buffered writes anyway. 
> > 
> > This works in 2.4.10 
> 
> iirc, this was disabled shortly after 2.4.10 (like 2.4.11-pre1 or 2).
> i believe the flag is still valid, however, i think the direct_io internals 
> were removed.

Yes, I fixed it in my tree.

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15pre1aa1/00_o_direct-4

Please Linus or Marcelo apply the above patch to the kernel.

Andrea
