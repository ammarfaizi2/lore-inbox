Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbRGFPCn>; Fri, 6 Jul 2001 11:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266713AbRGFPCe>; Fri, 6 Jul 2001 11:02:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22802 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266712AbRGFPC2>; Fri, 6 Jul 2001 11:02:28 -0400
Date: Fri, 6 Jul 2001 17:02:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Thibaut Laurent <thibaut@celestix.com>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010706170233.X2425@athlon.random>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de> <20010705162035.Q17051@athlon.random> <3B447B6D.C83E5FB9@redhat.com> <20010705164046.S17051@athlon.random> <20010705233200.7ead91d5.thibaut@celestix.com> <20010706144311.J2425@athlon.random> <20010706221853.3391f528.thibaut@celestix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010706221853.3391f528.thibaut@celestix.com>; from thibaut@celestix.com on Fri, Jul 06, 2001 at 10:18:53PM +0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 10:18:53PM +0800, Thibaut Laurent wrote:
> Confirmed. I tried both pre2 and pre3
> 
> 2.4.7-pre2 + 00_ksoftirqd-7 + your last "bug" patch --> boot failed
> 2.4.7-pre3 + 00_ksoftirqd-7 + your last "bug" patch --> boot ok

perfect.

> BTW, is there some kind of doc regarding all the patches in
> ftp.kernel.org/pub/linux/kernel/people/andrea/kernels ?
> Especially, what each of them is meant for.

there are the .log files for each patchkit, most of the time I only
document the diffs between different patchkits since it's faster that
way but if lots of people asks for that I can automate the build of the
whole description for every patchkit too.

Andrea
