Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLYLkl>; Mon, 25 Dec 2000 06:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQLYLka>; Mon, 25 Dec 2000 06:40:30 -0500
Received: from cicero1.cybercity.dk ([212.242.40.4]:54797 "HELO
	cicero1.cybercity.dk") by vger.kernel.org with SMTP
	id <S129408AbQLYLk0>; Mon, 25 Dec 2000 06:40:26 -0500
Date: Mon, 25 Dec 2000 12:10:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Gilbert <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: css hang; somewhere between test12 and test13pre4ac2
Message-ID: <20001225121037.B303@suse.de>
In-Reply-To: <Pine.LNX.4.10.10012242340530.666-100000@tardis.home.dave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10012242340530.666-100000@tardis.home.dave>; from gilbertd@treblig.org on Sun, Dec 24, 2000 at 11:42:47PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24 2000, Dave Gilbert wrote:
> Hi,
>   Somewhere between test12 and test13pre4ac2 (sheesh the version
> numbers.....) CSS on ATAPI DVD ROM drives has stopped working.
> 
> Playing a CSS disc (using xine) causes a complete system hang (machine
> doesn't ping - sysrq-b still works) on test13pre4ac2.  On test12 it is
> still OK.
> 
> This is on an Alpha LX164.

The most likely suspect (as someone else pointed out) is not at
all css (I'm not even sure what you mean by css hang?) but UDF.
Given the fs changes. Since sysrq still works, it would help a
lot if you could capture sysrq-p repeatedly and send it in.

Do you have any non-css discs to beat on UDF?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
