Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129992AbQLSKCG>; Tue, 19 Dec 2000 05:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbQLSKB4>; Tue, 19 Dec 2000 05:01:56 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16474 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129761AbQLSKBt>; Tue, 19 Dec 2000 05:01:49 -0500
Date: Tue, 19 Dec 2000 10:30:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Pavel Machek <pavel@suse.cz>, Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <20001219103030.A29228@athlon.random>
In-Reply-To: <20001219012714.B26127@athlon.random> <Pine.LNX.3.96.1001219092835.20423A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1001219092835.20423A-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Tue, Dec 19, 2000 at 09:42:05AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 09:42:05AM +0100, Mikulas Patocka wrote:
> Failing getblk would likely introduce filesystem corruption. Look at
> getblk in 2.0 - when allocating new page fails it tries to reuse existing
> clean buffers or wakes up bdflush and waits until it writes them. This is
> the right thing to do. 

wrong.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
