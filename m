Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261688AbSKCIg6>; Sun, 3 Nov 2002 03:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSKCIg6>; Sun, 3 Nov 2002 03:36:58 -0500
Received: from pfaff.Stanford.EDU ([128.12.189.154]:52696 "EHLO
	pfaff.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S261688AbSKCIg5>; Sun, 3 Nov 2002 03:36:57 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 / fb vga16fb build error
References: <20021103035831.GW619@zip.com.au>
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: 03 Nov 2002 00:42:11 -0800
In-Reply-To: <20021103035831.GW619@zip.com.au>
Message-ID: <87fzuj2gf0.fsf@pfaff.Stanford.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> writes:

> gcc -Wp,-MD,drivers/video/.vga16fb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DKBUILD_BASENAME=vga16fb -c -o drivers/video/vga16fb.o drivers/video/vga16fb.c
> drivers/video/vga16fb.c: In function `vga16fb_set_disp':
> drivers/video/vga16fb.c:177: structure has no member named `visual'
> drivers/video/vga16fb.c:178: structure has no member named `type'
[...]

I posted a fix for this a while ago (perhaps a week or two ago).
I think Alan Cox picked it up but it may not have made it into
any Linus kernel yet.
-- 
"In this world that Hugh Heffner had made,
 he alone seemed forever bunnyless."
--John D. MacDonald
