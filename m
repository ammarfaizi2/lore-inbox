Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279965AbRJ3OtE>; Tue, 30 Oct 2001 09:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279961AbRJ3Osz>; Tue, 30 Oct 2001 09:48:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9570 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S279960AbRJ3Osp>; Tue, 30 Oct 2001 09:48:45 -0500
Date: Tue, 30 Oct 2001 15:49:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.ent,
        torvalds@transmeta.com
Subject: Re: VM test comparison of 2.4.14-pre5, aa1, and 2.4.13-ac5-fs
Message-ID: <20011030154911.E1340@athlon.random>
In-Reply-To: <20011030022640.A225@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011030022640.A225@earthlink.net>; from rwhron@earthlink.net on Tue, Oct 30, 2001 at 02:26:40AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 02:26:40AM -0500, rwhron@earthlink.net wrote:
> 2.4.14-pre5
> -----------
> 
> mtest01
> 
> mp3 played 263 seconds of 321 second run.
> 
> Averages for 10 mtest01 runs
> bytes allocated:                    1241933414
> bytes allocated:                    1250217164
> bytes allocated:                    1244345139

the mtest01 -p may comparing apples to oranges. Please make sure to apply
the -p fix I posted in the last days before using the -p option,
otherwise the amount of memory swapped out will be random. In this case
the -aa run was a little penalized for example (not much but since the
difference is of the order of seconds ...).

thanks!

Andrea
