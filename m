Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAIFbY>; Tue, 9 Jan 2001 00:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAIFbO>; Tue, 9 Jan 2001 00:31:14 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:8210 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129267AbRAIFbE>; Tue, 9 Jan 2001 00:31:04 -0500
Date: Mon, 8 Jan 2001 21:30:44 -0800
From: Richard Henderson <rth@twiddle.net>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: richbaum@acm.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
Message-ID: <20010108213044.A28968@twiddle.net>
In-Reply-To: <3A5790E3.18256.963C79@localhost> <20010108205001.S3472@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010108205001.S3472@arthur.ubicom.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 08:50:01PM +0100, Erik Mouw wrote:
> Is this really a kernel bug? This is common idiom in C, so gcc
> shouldn't warn about it. If it does, it is a bug in gcc IMHO.

No, it is not a common idiom in C.  It has _never_ been valid C.

GCC originally allowed it due to a mistake in the grammar; we
now warn for it.  Fix your source.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
