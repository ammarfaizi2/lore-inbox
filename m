Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSGEOqC>; Fri, 5 Jul 2002 10:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSGEOqB>; Fri, 5 Jul 2002 10:46:01 -0400
Received: from molly.vabo.cz ([160.216.153.99]:9223 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id <S317463AbSGEOqA>;
	Fri, 5 Jul 2002 10:46:00 -0400
Date: Fri, 5 Jul 2002 16:48:28 +0200 (CEST)
From: Tomas Konir <moje@molly.vabo.cz>
X-X-Sender: moje@moje.ich.vabo.cz
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?
In-Reply-To: <20020705142619.GN1007@suse.de>
Message-ID: <Pine.LNX.4.44L0.0207051643580.709-100000@moje.ich.vabo.cz>
References: <Pine.LNX.4.43.0207051524480.9092-100000@cibs9.sns.it>
 <Pine.LNX.4.44L0.0207051606050.32493-100000@moje.ich.vabo.cz>
 <20020705142619.GN1007@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002, Jens Axboe wrote:

> > hi i have similar problem.
> > No dead disks, but after two days testing tcq patches (on 2.4). I 
> > got the two ATA errors (smartctl said). 
> > I think that it's no good to test tcq on IBM disks. My disk was without 
> > any problems one year. Two problems now is not normal.
> 
> I find this hard to believe (why would using a different set of
> read/write commands show problems?!), and so far the evidence is far
> from conclusive. I'll be watching it, though.

If it helps I'll send you complete Log error structure from smartct.

Error Log Structure 1:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 00   08   80   ee   88   a2    e0   cc     1210341
 00   08   08   ee   88   a2    e0   a2     1210341
 00   08   87   04   1d   20    e0   cc     1210341
 00   00   00   04   1d   20    e0   00     1210341
 00   00   80   06   42   67    e1   c8     1210341
 00   84   00   85   42   67    e1   51     0
Error condition:   0    Error State:       3

Error Log Structure 2:
DCR   FR   SC   SN   CL   SH   D/H   CR   Timestamp
 00   80   00   3e   66   23    e1   c7     1386233
 00   80   08   3e   66   23    e0   a2     1386233
 00   80   30   be   66   23    e1   c7     1386233
 00   80   80   be   66   23    e1   c4     1386233
 00   08   08   26   32   a4    e0   cc     1386237
 00   84   00   2d   32   a4    e0   51     0
Error condition:   0    Error State:       3

> 
> > For final i think, that tcq patch is not fully stable, becouse on high 
> > disk load i get oops and have to reboot. I have no problem when i remove 
> > tcq patches.
> > (high load i mean copy cca 20GiB between two IBM disks).
> 
> Any reason you haven't reported this?! Please do so.

sorry but this oops was only on screen and i were no time for log this 
to the paper. After second error i removed tcq from my kernel.
(I have no money for new disk now).

	MOJE 
 
-- 
Tomas Konir
Brno
ICQ 25849167


