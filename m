Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290059AbSBFE7m>; Tue, 5 Feb 2002 23:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290062AbSBFE7c>; Tue, 5 Feb 2002 23:59:32 -0500
Received: from melancholia.rimspace.net ([210.23.138.19]:60936 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S290059AbSBFE71>; Tue, 5 Feb 2002 23:59:27 -0500
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Warning, 2.5.3 eats filesystems
In-Reply-To: <20020205192826.GA112@elf.ucw.cz>
	<878za7wmg0.fsf@inanna.rimspace.net>
	<20020206010219.YXFM10804.out006.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
	<20020206023937.G25441@suse.de>
In-Reply-To: <20020206023937.G25441@suse.de> (Dave Jones's message of "Wed,
 6 Feb 2002 02:39:37 +0100")
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Wed, 06 Feb 2002 15:59:16 +1100
Message-ID: <87vgdb5hp7.fsf@inanna.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, Dave Jones wrote:
> On Tue, Feb 05, 2002 at 07:59:57PM -0500, Skip Ford wrote:
>  > I can confirm inode errors also. However, I can't be sure it's
>  > 2.5.3 that did it.
> 
>  Recall that pre3/pre4/pre5 had the missing ext2_inode_info
>  initialisation bug. If you booted any of those, and have only just
>  done a fsck, it could be a leftover artifact of a now-fixed bug.

I jumped directly from 2.4.18pre1 to 2.5.3, and I didn't see any issues
with the 2.4 kernel in the time I ran it.

This doesn't rule out a pre-existing corruption, of course, but it seems
to me unlikely in the extreme. Er, in my case, of course. I can't speak
for others.

        Daniel

-- 
Yes, I hate that. You spend all this time trying to explain to people that
they don't *have* to hammer nails into their own heads all the time, only to
discover that they *like* it because it's all they've ever known.
        Tim Bradshaw, _comp.lang.lisp_
