Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281543AbRKMGpp>; Tue, 13 Nov 2001 01:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281544AbRKMGph>; Tue, 13 Nov 2001 01:45:37 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:27590 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281543AbRKMGpU>; Tue, 13 Nov 2001 01:45:20 -0500
Date: Tue, 13 Nov 2001 07:45:14 +0100 (CET)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.hbh.net
To: Frank de Lange <lkml-frank@unternet.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal interactive performance on 2.4.linus
In-Reply-To: <20011112235642.A17544@unternet.org>
Message-ID: <Pine.LNX.4.40.0111130740230.10017-100000@omega.hbh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.27)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Seems that reiserfs is the common factor here, at least on my box. This is a 35
> GB reiserfs filesystem, app 80% used, both large and small files.
>
> As said in my previous message, the numbers themselves don't mean squat. It is
> the large delays (the fact that user+sys <<< real) which are the problem here.

This was also reported as

Suspected bug - System slowdown under unexplained excessive disk I/O - 2.4.13
with huge delays during compiles (sasha Pachev) or mysql-benchmarks (me).
But today I do not find this reiser-specific, this also seems to happen
with ext3.
But as you wrote, not with ext2. I see that there is more disk-activity
due to journaling in both cases, but waiting 30 seconds for simple tasks
or waking from screen-apm seems not to be right.


Oktay Akbal

