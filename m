Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284251AbRLTLo1>; Thu, 20 Dec 2001 06:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284369AbRLTLoR>; Thu, 20 Dec 2001 06:44:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:50969 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284251AbRLTLoJ>; Thu, 20 Dec 2001 06:44:09 -0500
Date: Thu, 20 Dec 2001 12:34:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
Message-ID: <20011220123437.W1395@athlon.random>
In-Reply-To: <87bsgwi6zz.fsf@fadata.bg> <Pine.LNX.4.21.0112181757460.4821-100000@freak.distro.conectiva> <3C1FC254.525B9108@zip.com.au> <3C1FCB96.83E49ECB@zip.com.au> <3C204C4F.C989AD71@zip.com.au>, <3C204C4F.C989AD71@zip.com.au>; <20011219144213.A1395@athlon.random> <3C21963B.AD97D4@zip.com.au> <20011220122735.V1395@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011220122735.V1395@athlon.random>; from andrea@suse.de on Thu, Dec 20, 2001 at 12:27:35PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 12:27:35PM +0100, Andrea Arcangeli wrote:
> the loop thread to use I/O methods to release memory should be just
> enough to have a stable system performing well.

Forget to tell, I'd really love to be proved wrong on this one on
practice (if you have a patch that makes the system faster than rc2aa1
you will certainly change my mind in a jiffy), just catch rc2aa1 and see
if the loop is performing well for you or not, it'm safisfied with it
here.

My main worry at the moment is the other deadlock report of yesterday
(still waiting the SYSRQ+T to see what gone wrong for him :)

Andrea
