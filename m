Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132076AbQLHSjX>; Fri, 8 Dec 2000 13:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132289AbQLHSjN>; Fri, 8 Dec 2000 13:39:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13120 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132076AbQLHSjH>; Fri, 8 Dec 2000 13:39:07 -0500
Date: Fri, 8 Dec 2000 19:08:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Martin Kacer <M.Kacer@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.2.18pre25
Message-ID: <20001208190829.A17848@inspiron.random>
In-Reply-To: <20001208012052.A23992@inspiron.random> <Pine.LNX.4.30.0012081738140.7409-100000@duck.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0012081738140.7409-100000@duck.sh.cvut.cz>; from M.Kacer@sh.cvut.cz on Fri, Dec 08, 2000 at 06:02:57PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2000 at 06:02:57PM +0100, Martin Kacer wrote:
>    Is there any chance to get rid of these VMM failures?

You should apply this patch on top of 2.2.18pre25:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre25/VM-global-2.2.18pre25-7.bz2

>    It seems we need to return back to 2.2.13 for some time. :-(

Definitely no, you only need to apply the above collection of bugfixes.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
