Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbRGEOA0>; Thu, 5 Jul 2001 10:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264896AbRGEOAP>; Thu, 5 Jul 2001 10:00:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:6916 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264883AbRGEN76>; Thu, 5 Jul 2001 09:59:58 -0400
Date: Thu, 5 Jul 2001 15:59:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT please; Sybase 12.5
Message-ID: <20010705155942.P17051@athlon.random>
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com> <E15Fuul-0008SJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15Fuul-0008SJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jun 29, 2001 at 10:50:15AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2001 at 10:50:15AM +0100, Alan Cox wrote:
> > the boss say "If Linux makes Sybase go through the page cache on
> > reads, maybe we'll just have to switch to Solaris.  That's
> > a serious performance problem."
> 
> Thats something you'd have to benchmark. It depends on a very large number
> of factors including whether the database uses mmap, the average I/O size
> and the like

correct, here the benchmarks:

	http://boudicca.tux.org/hypermail/linux-kernel/2001week17/1175.html
        http://boudicca.tux.org/hypermail/linux-kernel/2001week17/att-1175/01-directio.png

of course the huge improvement is also because of broken VM in the
buffered-io case.

Andrea
