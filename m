Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131591AbQKAVAg>; Wed, 1 Nov 2000 16:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131602AbQKAVA1>; Wed, 1 Nov 2000 16:00:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9300 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131591AbQKAVAR>; Wed, 1 Nov 2000 16:00:17 -0500
Date: Wed, 1 Nov 2000 22:00:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Yann Dirson <ydirson@altern.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine hangs)
Message-ID: <20001101220002.A17134@athlon.random>
In-Reply-To: <20001101174816.A18510@athlon.random> <Pine.LNX.4.21.0011011456430.11112-100000@duckman.distro.conectiva> <20001101220326.A4514@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001101220326.A4514@bylbo.nowhere.earth>; from ydirson@altern.org on Wed, Nov 01, 2000 at 10:03:27PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 10:03:27PM +0100, Yann Dirson wrote:
> On Wed, Nov 01, 2000 at 02:59:01PM -0200, Rik van Riel wrote:
> 
> Andrea wrote:
> > (btw, make sure you're using the -7 revision of the VM-global patch, as it
> > includes the same MM corruption bugfix that is been included into 18pre18)
> 
> Damn, I was using -6.  http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre9/ does not have -7.
> Neither does your e-mind repository hlinked from linux-mm.
> 
> I'm currently running -6 :(

A -7 to apply to 2.2.18pre17 and _previous_ releases is in the directory
patches/v2.2/2.2.18pre17/. An equivalent one against 2.2.18pre18 (and probably
future releases) is in patches/v2.2/2.2.18pre18/.

After applying the patch you should make sure there are no rejects with a `find
-name \*.rej`.  If there aren't rejects all gone right.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
