Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318518AbSIBW1a>; Mon, 2 Sep 2002 18:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318526AbSIBW1a>; Mon, 2 Sep 2002 18:27:30 -0400
Received: from hacksaw.org ([216.41.5.170]:14729 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S318518AbSIBW13>; Mon, 2 Sep 2002 18:27:29 -0400
Message-Id: <200209022233.g82MXXgB015673@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 08/15/2002 with nmh-1.0.4
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c 
In-reply-to: Your message of "Mon, 02 Sep 2002 15:43:56 MDT."
             <Pine.LNX.4.44.0209021542590.3270-100000@hawkeye.luckynet.adm> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Sep 2002 18:33:33 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Speaking from the perspective of a long time computer user and sys-admin, I'm 
trying to understand life without a partition table.

I operate under the following assumptions:

1. It's useful to have a physical disk divided into multiple logical disks.
2. It's therefore important that the bootloader know about them, assuming that 
we want to be able to boot from any logical disk.
3. We can either have the bootloader spend time divining the structure of the 
logical disks by scanning the physical disk or we can write it down in some 
useful place.
4. That useful place is very near the front of the physical disk.

Of course, I'd be the first to admit that the current partition table is a 
stupid design, but I can't see not having one at all.


-- 
We have three rights:
   the right to work, the right to pay to work, and the right to suffer the 
consequences of our work.
We have three obligations:
   the obligation to work, the obligation to pay to work, and the obligation 
to suffer the consequences of our work.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


