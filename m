Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbRFURM7>; Thu, 21 Jun 2001 13:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265052AbRFURMt>; Thu, 21 Jun 2001 13:12:49 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22040 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265051AbRFURMc>; Thu, 21 Jun 2001 13:12:32 -0400
Date: Thu, 21 Jun 2001 19:12:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stefan.Bader@de.ibm.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>
Subject: Re: correction: fs/buffer.c underlocking async pages
Message-ID: <20010621191218.A28327@athlon.random>
In-Reply-To: <20010621170813.F29084@athlon.random> <Pine.LNX.4.33.0106210951530.1260-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106210951530.1260-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jun 21, 2001 at 09:54:47AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 09:54:47AM -0700, Linus Torvalds wrote:
> The above _will_ break. "tmp" may be locked due to the write - and the

indeed, I missed the pending writes sorry.

Andrea
