Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLWT5v>; Sat, 23 Dec 2000 14:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLWT5m>; Sat, 23 Dec 2000 14:57:42 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:29960 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129260AbQLWT51>; Sat, 23 Dec 2000 14:57:27 -0500
Date: Sat, 23 Dec 2000 14:25:21 -0500
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alexander Viro <viro@math.psu.edu>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <331770000.977599521@coffee>
In-Reply-To: <Pine.LNX.4.10.10012231100190.2174-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Saturday, December 23, 2000 11:02:53 -0800 Linus Torvalds
<torvalds@transmeta.com> wrote:
> 
> Which is why I prefer the higher layers handling the dirty/uptodate/xxx
> bits. 
> 

Grin, I should have taken the hint when we talked about the buffer up to
date checks for block_read_full_page, it made sense then too.  

brw_page doesn't clear the dirty bit in pre4, was that on purpose?

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
