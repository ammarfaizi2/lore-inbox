Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263660AbRFASbr>; Fri, 1 Jun 2001 14:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263669AbRFASbf>; Fri, 1 Jun 2001 14:31:35 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:14085 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S263660AbRFASbT>;
	Fri, 1 Jun 2001 14:31:19 -0400
Date: Sun, 27 May 2001 06:38:31 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010527063830.A36@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0105250959580.11312-100000@penguin.transmeta.com> <Pine.GSO.4.21.0105251325380.27664-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0105251325380.27664-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, May 25, 2001 at 01:40:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I can easily give more examples - just ask. BTW, the fact that this stuff
> is so fragmented is not a bug - we want it evenly spread over disk, just
> to have the ability to allocate a block/inode not too far from the piece
> of bitmap we'll need to modify.

BTW is this still true? This assumes that long seek takes more time than
short seek. With 12.000rpm drive, one rotation takes 5msec. "Full" seek
is around 12msec these days, no?

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

