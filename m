Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129362AbQJ3SDO>; Mon, 30 Oct 2000 13:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQJ3SDE>; Mon, 30 Oct 2000 13:03:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:58458 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129534AbQJ3SCu>; Mon, 30 Oct 2000 13:02:50 -0500
Date: Mon, 30 Oct 2000 19:02:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andi Kleen <ak@suse.de>, dean gaudet <dean-list-linux-kernel@arctic.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>, kumon@flab.fujitsu.co.jp,
        Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        linux-kernel@vger.kernel.org, Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was:
Message-ID: <20001030190204.E21935@athlon.random>
In-Reply-To: <20001030162815.B21935@athlon.random> <Pine.LNX.4.21.0010301435050.16609-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0010301435050.16609-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Oct 30, 2000 at 02:36:39PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 02:36:39PM -0200, Rik van Riel wrote:
> For stuff like ___wait_on_page(), OTOH, you really want FIFO
> wakeup to avoid starvation (yes, I know we're currently doing

Sure agreed. In my _whole_ previous email I was only talking about accept.
Semaphores file locking etc.. all needs FIFO for fairness as you said.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
