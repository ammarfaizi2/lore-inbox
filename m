Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbTAETpf>; Sun, 5 Jan 2003 14:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbTAETpf>; Sun, 5 Jan 2003 14:45:35 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:48908 "EHLO
	boo-mda02.boo.net") by vger.kernel.org with ESMTP
	id <S265051AbTAETpd>; Sun, 5 Jan 2003 14:45:33 -0500
Message-Id: <3.0.6.32.20030105150405.007dead0@boo.net>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Sun, 05 Jan 2003 15:04:05 -0500
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: Re: [PATCH] rewritten page coloring for 2.4.20 kernel
In-Reply-To: <20030105193411.GJ9704@holomorphy.com>
References: <200301051603.LAA18650@boo-mda02.boo.net>
 <200301051603.LAA18650@boo-mda02.boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:34 AM 1/5/03 -0800, you wrote:

>At some point in the past, jasonp wrote:
>>> Any chance for a 2.5.x-mm port? This is a bit feature-ish for 2.4.x.
>
>On Sun, Jan 05, 2003 at 04:03:33PM +0000, jasonp@boo.net wrote:
>> I know. The problem is that 2.5.53 cannot finish booting on the Alpha I have
>> here (IDE issues). While I can port the patch over, I'm not comfortable being
>> unable to test it at all.
>
>What kind of Alpha? Got an oops/backtrace?
>
>I probably can't reproduce it directly since my Alpha's diskless.

The machine in question is a DS10 Alphaserver (DP264 type chipset) using an
ALI M5229 rev c1 IDE controller (uses the ALI 15x3 driver). The stock 2.5.53
kernel panics at boot time because it can't find the root partition; when I
first reported the problem, one of the maintainers passed on a patch that
resolved some 2.5 IDE issues. With the patch in place, the boot process gets
farther along but occaisionally there will be a printout that hda lost an 
interrupt. I don't know how far it really gets, because I gave up after other
subsystems started reporting errors.

I haven't tried 2.5.54, either. I will shortly.

Is 2.4 really in bug-fix mode now? 2.4.19 and 2.4.20 were huge patches.

Thanks,
jasonp
