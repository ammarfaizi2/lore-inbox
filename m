Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284765AbRLEWZs>; Wed, 5 Dec 2001 17:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284767AbRLEWZi>; Wed, 5 Dec 2001 17:25:38 -0500
Received: from ns.suse.de ([213.95.15.193]:17674 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284765AbRLEWZY>;
	Wed, 5 Dec 2001 17:25:24 -0500
Date: Wed, 5 Dec 2001 23:25:23 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Ben Pharr - Lists <ben-lists@benpharr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Missing Files
In-Reply-To: <5.1.0.14.0.20011205160555.00a10ec0@sunset.olemiss.edu>
Message-ID: <Pine.LNX.4.33.0112052323440.18145-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Ben Pharr - Lists wrote:

> gcc -D__KERNEL__ -I/usr/src/linux-2.4.17-pre4/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686  -E -D__GENKSYMS__ sa1100fb.c
> | /sbin/genksyms  -k 2.4.17 >
> /usr/src/linux-2.4.17-pre4/include/linux/modules/sa1100fb.ver.tmp
> sa1100fb.c:164: linux/cpufreq.h: No such file or directory

Looks like an incomplete ARM sync. But why are you trying to
build sa1100fb on x86 anyway ?

regards,
Dave.


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

