Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135781AbRAWAyq>; Mon, 22 Jan 2001 19:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135922AbRAWAyg>; Mon, 22 Jan 2001 19:54:36 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:36103 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S135880AbRAWAyZ>;
	Mon, 22 Jan 2001 19:54:25 -0500
Date: Tue, 23 Jan 2001 01:54:07 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Admin Mailing Lists <mlist@intergrafix.net>
Cc: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
Message-ID: <20010123015407.F4979@almesberger.net>
In-Reply-To: <20010122082254.D9530@work.bitmover.com> <Pine.LNX.4.10.10101221817170.12017-100000@athena.intergrafix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101221817170.12017-100000@athena.intergrafix.net>; from mlist@intergrafix.net on Mon, Jan 22, 2001 at 06:20:49PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Admin Mailing Lists wrote:
>    hand-holding of that magnitude. We don't write code for idiots.

But if you have to, you can at least enjoy it:
 - diversity makes life interesting: use switch() with local variables or
   without curly braces
 - de-referencing is like a hotel: the more stars, the better
 - observe proper punctuation: use the comma operator frequently
 - know thy C: few people know that 5[x] is valid, but they can usually
   guess what it does. They probably won't get x[5[y]], though.
 - know thy CPP: nest macros and exercise token-concatenation and
   stingification
 - if your code allows you to, put  #define while if  in some header file

- Werner (couldn't resist ;-)

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
