Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278636AbRJ1TCB>; Sun, 28 Oct 2001 14:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278643AbRJ1TBw>; Sun, 28 Oct 2001 14:01:52 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:55558 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278636AbRJ1TBf>; Sun, 28 Oct 2001 14:01:35 -0500
Message-ID: <3BDC54D8.213F7003@zip.com.au>
Date: Sun, 28 Oct 2001 10:56:24 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Zlatko Calusic <zlatko.calusic@iskon.hr>, Jens Axboe <axboe@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <E15xu2b-0008QL-00@the-village.bc.nu> <Pine.LNX.4.33.0110280945150.7360-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> And it may be that the hpt366 IDE driver has always had this braindamage,
> which the -ac code hides. Or something like this.
> 

My hpt366, running stock 2.4.14-pre3 performs OK.
	time ( dd if=/dev/zero of=foo bs=10240k count=100 ; sync )
takes 35 seconds (30 megs/sec).  The same on current -ac kernels.

Maybe Zlatko's drive stopped doing DMA?
