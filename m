Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130559AbRACUPc>; Wed, 3 Jan 2001 15:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130344AbRACUPX>; Wed, 3 Jan 2001 15:15:23 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31044 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130614AbRACUPK>; Wed, 3 Jan 2001 15:15:10 -0500
Date: Wed, 3 Jan 2001 20:43:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache 2nd chance replacement
Message-ID: <20010103204354.E32185@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0101031653100.1403-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101031653100.1403-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Jan 03, 2001 at 04:59:16PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 04:59:16PM -0200, Rik van Riel wrote:
> I know this probably isn't of any help under very low
> and very high loads, but it should provide a nice
> improvement under medium loads...

It should provide an improvement under high VFS load (lots of files lookedup
and not kept referenced all the time).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
