Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbTBOL0U>; Sat, 15 Feb 2003 06:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbTBOL0U>; Sat, 15 Feb 2003 06:26:20 -0500
Received: from mail.gmx.net ([213.165.65.60]:25538 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261624AbTBOL0T>;
	Sat, 15 Feb 2003 06:26:19 -0500
Message-Id: <5.1.1.6.2.20030215123533.00cd3e70@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sat, 15 Feb 2003 12:40:55 +0100
To: Rik van Riel <riel@conectiva.com.br>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] CFQ scheduler, #2
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50L.0302150920510.16301-100000@imladris.surriel
 .com>
References: <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net>
 <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:22 AM 2/15/2003 -0200, Rik van Riel wrote:
>On Sat, 15 Feb 2003, Mike Galbraith wrote:
>
>>I gave this a burn, and under hefty load it seems to provide a bit of
>>anti-thrash benefit.
>
>Judging from your log, it ends up stalling kswapd and
>dramatically increases the number of times that normal
>processes need to go into the pageout code.
>
>If this provides an anti-thrashing benefit, something's
>wrong with the VM in 2.5 ;)

Which number are you looking at?

         -Mike

