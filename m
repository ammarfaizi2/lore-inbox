Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbQLaSun>; Sun, 31 Dec 2000 13:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130535AbQLaSud>; Sun, 31 Dec 2000 13:50:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:59417 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129370AbQLaSuS>; Sun, 31 Dec 2000 13:50:18 -0500
Date: Sun, 31 Dec 2000 19:19:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001231191948.C8027@athlon.random>
In-Reply-To: <20001231182127.A24348@gruyere.muc.suse.de> <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com> <20001231183650.A24467@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001231183650.A24467@gruyere.muc.suse.de>; from ak@suse.de on Sun, Dec 31, 2000 at 06:36:50PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 06:36:50PM +0100, Andi Kleen wrote:
> AFAIK alpha has byte instructions now.

See other post. Only from ev6 (at least as far as gcc is concerned). I've an
userspace testcase here (it was originally an obscure alpha userspace MM
corruption bug report that I sorted out some time ago) that works only only
when compiled for ev6 because it needs `short' granularity (not even byte
granularity).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
