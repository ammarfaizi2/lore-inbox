Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbRE2TxW>; Tue, 29 May 2001 15:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbRE2TxM>; Tue, 29 May 2001 15:53:12 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:30131 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S261617AbRE2Twy>;
	Tue, 29 May 2001 15:52:54 -0400
Date: Tue, 29 May 2001 15:52:47 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
X-X-Sender: <fxian@tiger>
To: <linux-kernel@vger.kernel.org>
Subject: linux-2.4.3-ac14 spinlock problem?
Message-ID: <Pine.LNX.4.33.0105291550400.28008-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I was running something on my Dell dual p3 box (optiplex gx300). my kernel
is linux-2.4.3-ac14. I got the following message:


__rwsem_do_wake(): wait_list unexpectedly empty
[4191] c5966f60 = { 00000001 })
kenel BUG at rwsem.c:99!
invalid operand: 0000
CPU:            1
EIP:            0010:[<c0236b99>]
EFLAGS: 00010282
kenel BUG at /usr/src/2.4.3-ac14/include/asm/spinlock.h:104!


I upgrade the kernel to 2.4.5, no such problem any more.

Any idea?

Alex


-- 
        Feng Xian
   _o)     .~.      (o_
   /\\     /V\      //\
  _\_V    // \\     V_/_
         /(   )\
          ^^-^^
           ALEX

