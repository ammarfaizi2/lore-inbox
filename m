Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273176AbRJTMng>; Sat, 20 Oct 2001 08:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273204AbRJTMnR>; Sat, 20 Oct 2001 08:43:17 -0400
Received: from mail3.home.nl ([213.51.129.227]:31629 "EHLO mail3.home.nl")
	by vger.kernel.org with ESMTP id <S273176AbRJTMnO>;
	Sat, 20 Oct 2001 08:43:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: elko <elko@home.nl>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] updated preempt-kernel
Date: Sat, 20 Oct 2001 14:44:14 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <1003562833.862.65.camel@phantasy>
In-Reply-To: <1003562833.862.65.camel@phantasy>
Cc: linux-kernel@vger.kernel.org
X-Owner: ElkOS
MIME-Version: 1.0
Message-Id: <01102014441400.00692@ElkOS>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 October 2001 09:27, Robert Love wrote:
> Testers Wanted:
>
> patches to enable a fully preemptible kernel are available at:
> 	http://tech9.net/rml/linux
> for kernels 2.4.10, 2.4.12, 2.4.12-ac3, and 2.4.13-pre5.
>

I just switched from 2.4.10-ac12-preempt to the following:

2.4.12 patched with 2.4.12-ac3, 2.4.12-ac3-vmpatch, 2.4.12-ac3-freeswap,
preempt-kernel-rml-2.4.12-ac3-2 (where is the stats-patch for that last
one?)

Compiling went without problems!

On a 850Mhz CPU with 576Mb Memory;
I did the following, all at the same time, started in this order:

X with KDE 2.1, gkrellm, licq, freeamp, 5* konqueror, kmail,
bonnie++, `du /home|sort -nr|head -100' (11+ Gig of files),
`slocate *|wc -l', `find /|wc -l', make Python and test it
(117 tests went OK1 test failed: test_openpty).

During this period, everything kept very responsive, there were
2 times a little delay would occur when moving a window like crazy,
or scrolling a konqueror page would delay a bit (it's only a 32Mb
card and no accel.), but switching desktops went fine and more
important, freeamp did not skip a single time !!!!

You should see the laugh on my face while I'm typing this ;^)


Any other testing you can think of ??

-- 
ElkOS: 2:20pm up 2:17, 3 users, load average: 2.66, 3.18, 3.60
bofhX: We've run out of licenses

