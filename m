Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTLBTMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTLBTMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:12:23 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:7925 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S263370AbTLBTMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:12:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: "Stefan J. Betz" <stefan_betz@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: include/linux/version.h
Date: Tue, 2 Dec 2003 14:12:18 -0500
User-Agent: KMail/1.5.1
References: <S263281AbTLBSis/20031202183848Z+2508@vger.kernel.org>
In-Reply-To: <S263281AbTLBSis/20031202183848Z+2508@vger.kernel.org>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312021412.18344.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.54.127] at Tue, 2 Dec 2003 13:12:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 December 2003 13:35, Stefan J. Betz wrote:
>Hello People,
>
>i have found some wrong thing in include/linux/version.h
>On my System i have Kernel 2.6.0-test10 & 2.6.0-test11, but in
>include/linux/version.h i see:
>#define UTS_RELEASE "2.6.0-test9"
>
>correct where:
>#definde UTS_RELEASE "2.6.0-test11" (for Linux Kernel
> 2.6.0-test11)...
>
>Here is a little "patch":
>
>diff -Nru linux-2.6.0-test11/include/linux/version.h
> linux-2.6.0-test11-fixed/include/linux/version.h ---
> linux-2.6.0-test11/include/linux/version.h	Tue Dec  2 19:21:22 2003
> +++ linux-2.6.0-test11-fixed/include/linux/version.h	Tue Dec  2
> 19:22:06 2003 @@ -1,3 +1,3 @@
>-#define UTS_RELEASE "2.6.0-test9"
>+#define UTS_RELEASE "2.6.0-test11"
> #define LINUX_VERSION_CODE 132608
> #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
>
>I know that this is not a very usefull fix, but i think 2.6.0 should
> be BugFree (TM) :-)
>
>Greeting Betz Stefan

Humm, where did you get your srcs from? include/linux/version.h reads 
2.6.0-test11 here...
>
>I know that my english is not realy good, but any tipp how i can
> learn better english is welcome...

An occasional miss-spelled word (tipp is really spelled tip) doesn't 
break our comprehension, do carry on.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

