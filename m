Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbRFUPZX>; Thu, 21 Jun 2001 11:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265006AbRFUPZE>; Thu, 21 Jun 2001 11:25:04 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:51461 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265003AbRFUPY7>; Thu, 21 Jun 2001 11:24:59 -0400
Date: Thu, 21 Jun 2001 17:24:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Stefan.Bader@de.ibm.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: correction: fs/buffer.c underlocking async pages
Message-ID: <20010621172433.J29084@athlon.random>
In-Reply-To: <20010621170813.F29084@athlon.random> <470160000.993136602@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470160000.993136602@tiny>; from mason@suse.com on Thu, Jun 21, 2001 at 11:16:42AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 11:16:42AM -0400, Chris Mason wrote:
> Think of a mixture of fsync_inode_buffers and async i/o on page.  Since
> fsync_inode_buffers uses ll_rw_block, if that end_io handler is the last to
> run the page never gets unlocked.

correct

Andrea
