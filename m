Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSEQMjo>; Fri, 17 May 2002 08:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315852AbSEQMjn>; Fri, 17 May 2002 08:39:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:62295 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315372AbSEQMjm>; Fri, 17 May 2002 08:39:42 -0400
Date: Fri, 17 May 2002 14:39:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Paul Faure <paul@engsoc.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
Message-ID: <20020517123902.GA11512@dualathlon.random>
In-Reply-To: <3CE46914.F4547F16@zip.com.au> <E178hAf-0006PS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 01:49:21PM +0100, Alan Cox wrote:
> I think its mostly #2. We invoke ksoftirq far far too easily.

ksoftirqd + SCHED_FIFO is like no ksoftirqd at all, provided the ne card
is irq driven (it is) everything works like it was working in 2.4.0.

Andrea
