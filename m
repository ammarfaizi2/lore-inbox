Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273504AbRIVHH5>; Sat, 22 Sep 2001 03:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274195AbRIVHHr>; Sat, 22 Sep 2001 03:07:47 -0400
Received: from [24.254.60.21] ([24.254.60.21]:37620 "EHLO
	femail31.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273504AbRIVHH3>; Sat, 22 Sep 2001 03:07:29 -0400
Date: Sat, 22 Sep 2001 03:04:25 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@zod.capslock.lan>
To: Stephane Brossier <stephane.brossier@sun.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: [1.] X session randomly crashes because of kernel
 problem.
In-Reply-To: <3BA56490.FD898C70@sun.com>
Message-ID: <Pine.LNX.4.33.0109220259410.25731-100000@zod.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001, Stephane Brossier wrote:

>Sep 16 19:13:59 129 modprobe: modprobe: Can't locate module binfmt-0000
>Sep 16 19:13:59 129 modprobe: modprobe: Can't locate module binfmt-0000
>Sep 16 19:13:59 129 kernel: [drm:r128_do_wait_for_fifo] *ERROR*
>r128_do_wait_for_fifo failed!

There is a patch which fixes problems such as this.  IIRC, it was
included in the upstream Linus kernel somewhere in April or
later.  If you're using XFree86 4.0.3, you'll probably want to
upgrade to a later kernel, or patch it with the r128 patch.  You
can get this patch from:

ftp://people.redhat.com/mharris/patches/linux-r128-drm.patch.bz2

I'd offer to change your mind for you, but I don't have a fresh diaper.
                   -- Leah to pro-spammer in news.admin.net-abuse.email

