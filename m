Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275346AbRJBP1N>; Tue, 2 Oct 2001 11:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275178AbRJBP1D>; Tue, 2 Oct 2001 11:27:03 -0400
Received: from sticks.phy.bris.ac.uk ([137.222.30.155]:19983 "EHLO
	sticks.phy.bris.ac.uk") by vger.kernel.org with ESMTP
	id <S275337AbRJBP0w>; Tue, 2 Oct 2001 11:26:52 -0400
Date: Tue, 2 Oct 2001 16:27:19 +0100
From: Major A <andras@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x with SMP on Alpha
Message-ID: <20011002162719.B9583@janus.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm just wondering what experiences you guys have with linux kernel
2.4.x configured for SMP on Alpha (UP2000/DP264). I tried the latest
two:

- 2.4.10: seems to fail to define the macro atomic_dec_and_lock
  (linux/spinlock.h) in various files like kernel/fork.c, resulting in
  undefined symbols. I think that linux/spinlock.h should be included
  (I followed the #include-s), but it isn't for some subtle reason.

- 2.4.9: bug in the pc_keyb driver, can be fixed with an extra
  #include, but even then some modules get undefined symbols (same as
  in 2.4.10).

Therefore I cannot run any of these kernels. The rest of the software
on this computer is a Debian potato (gcc 2.95.2).

Any feedback would be appreciated.

  Andras
