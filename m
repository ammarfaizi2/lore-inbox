Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265883AbUGMUuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUGMUuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUGMUuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:50:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57000 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265883AbUGMUug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:50:36 -0400
Date: Tue, 13 Jul 2004 22:48:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Murphy hits (Kernel 2.6, ext2, "check=strict"): corrupted filesystem
Message-ID: <20040713204833.GI3654@openzaurus.ucw.cz>
References: <40F251F1.1057.35E0C3@rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F251F1.1057.35E0C3@rkdvmks1.ngate.uni-regensburg.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'd like to present a little story how to shredder your ext2 filesystem:
> 
> I was installing SuSE Linux 9.1 when the kernel froze rather late during 
> installation. So I had to reset the PC. There is a minor bug in the forementioned 

You call this "minor"?

> Why I'm writing this: If something can go wrong, eventually it will. For a true 
> disaster you always need more than just one problem (1: Kernel freeze, 2: no fsck 
> being run, 3: kernel happily mounts unclean filesystem for read-write).

3 is feature. It prints warning, but lets you mount it. I sometimes mount
broken fs's rw; it actually saved me once when I was hitting fsck bug.
It is also handy when quickly recovering scratch machine.

MS-DOS had no fsck... and survive. ext2 can survive with similar results
if you just dont fsck...

> I think nobody really wants to read reports where Linux has shreddered a 
> filesystem, do we?

I actually liked your report ;-).
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

