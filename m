Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132088AbQL2TmM>; Fri, 29 Dec 2000 14:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132110AbQL2TmC>; Fri, 29 Dec 2000 14:42:02 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8544 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132088AbQL2Tl6>; Fri, 29 Dec 2000 14:41:58 -0500
Date: Fri, 29 Dec 2000 20:11:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Petru Paler <ppetru@ppetru.net>,
        Jakob Østergaard <jakob@unthought.net>,
        Jure Pecar <pegasus@telemach.net>, linux-kernel@vger.kernel.org,
        thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229201112.C16261@athlon.random>
In-Reply-To: <20001229202120.C573@ppetru.net> <E14C4hI-0005cK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14C4hI-0005cK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 29, 2000 at 06:56:09PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 06:56:09PM +0000, Alan Cox wrote:
> Depends on memory bandwidth, [..]

BTW, it could as well use TCP_CORK + sendfile that will become truly zero copy
eventually.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
