Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbRGFOcY>; Fri, 6 Jul 2001 10:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266709AbRGFOcO>; Fri, 6 Jul 2001 10:32:14 -0400
Received: from [203.126.57.231] ([203.126.57.231]:17924 "HELO
	mail.celestix.com") by vger.kernel.org with SMTP id <S266708AbRGFOcE>;
	Fri, 6 Jul 2001 10:32:04 -0400
Date: Fri, 6 Jul 2001 22:18:53 +0800
From: Thibaut Laurent <thibaut@celestix.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-Id: <20010706221853.3391f528.thibaut@celestix.com>
In-Reply-To: <20010706144311.J2425@athlon.random>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de>
	<20010705162035.Q17051@athlon.random>
	<3B447B6D.C83E5FB9@redhat.com>
	<20010705164046.S17051@athlon.random>
	<20010705233200.7ead91d5.thibaut@celestix.com>
	<20010706144311.J2425@athlon.random>
Organization: Celestix Networks Pte Ltd
X-Mailer: Sylpheed version 0.4.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001 14:43:11 +0200
Andrea Arcangeli <andrea@suse.de> wrote:

 | On Thu, Jul 05, 2001 at 11:32:00PM +0800, Thibaut Laurent wrote:
 | > And the winner is... Andrea. Kudos to you, I've just applied these patches,
 | > recompiled and it seems to work fine.
 | 
 | can you apply this patch on top of the ksoftirqd patch and see if you
 | can trigger the BUG() again when based on pre2? (I want to make sure to
 | be as strict as mainline) Then if you apply the same patches on top of
 | pre3 the BUG() should go away.

Confirmed. I tried both pre2 and pre3

2.4.7-pre2 + 00_ksoftirqd-7 + your last "bug" patch --> boot failed
2.4.7-pre3 + 00_ksoftirqd-7 + your last "bug" patch --> boot ok

BTW, is there some kind of doc regarding all the patches in
ftp.kernel.org/pub/linux/kernel/people/andrea/kernels ?
Especially, what each of them is meant for.

Best regards,

Thibaut

