Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSLSQzA>; Thu, 19 Dec 2002 11:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbSLSQzA>; Thu, 19 Dec 2002 11:55:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40171
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265830AbSLSQy7>; Thu, 19 Dec 2002 11:54:59 -0500
Subject: Re: 'D' processes on a healthy system?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin f krafft <madduck@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021219124043.GA28617@fishbowl.madduck.net>
References: <20021219124043.GA28617@fishbowl.madduck.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Dec 2002 17:43:52 +0000
Message-Id: <1040319832.28973.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 12:40, martin f krafft wrote:
> [please CC me on replies]
> 19268 madduck   18   0  2208 2208  1076 D     1.3  0.4   0:00 sanitizer
>     6 root       9   0     0    0     0 DW    0.3  0.0   1:10 kupdated
>  8457 root      10   0  1156 1156   820 R     0.3  0.2   0:02 top
> 10843 postfix    9   0  1364 1364  1016 D     0.3  0.2   0:00 cleanup
>  3156 madduck    0   0   636  636   540 D     0.1  0.1   0:00 procmail
> 28356 root       9   0   292  288   240 R     0.0  0.0   0:01 supervise
> 28706 root       9   0  2060 2036  1724 D     0.0  0.4   0:00 sshd
> 21395 root      15   0  1944 1944  1876 D     0.0  0.3   0:00 zsh
> 
> notice the number of processes in       ^
> uninterruptible sleep mode in this column.

Your disk is too slow for the work being asked of it, thats all.
Eventually it'll get there

> My laptop, which is running Debian testing/unstable is not showing
> this behaviour, and its load goes far higher at times. I also run
> various other servers, partially on P5-120 systems, vanilla 2.4.xx
> kernels and Debian testing, and there are no such problems there.

sendmail tuning ?

