Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262948AbSJBDS4>; Tue, 1 Oct 2002 23:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262949AbSJBDSz>; Tue, 1 Oct 2002 23:18:55 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:53916 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262948AbSJBDSv>; Tue, 1 Oct 2002 23:18:51 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
References: <Pine.LNX.4.44.0210012300001.23315-100000@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 02 Oct 2002 12:23:42 +0900
In-Reply-To: <Pine.LNX.4.44.0210012300001.23315-100000@localhost.localdomain>
Message-ID: <buoy99hcym9.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
> then lets at least have 'struct work' and 'struct work_queue' instead of
> 'struct work_struct', 'struct work_queue_struct'. "struct work" is already
> twice as large as "work_t".

I've always wondered about that -- why _does_ linux append `_struct' to
some structure names?  It seems completely redundant (and ugly).

Thanks,

-Miles
-- 
The secret to creativity is knowing how to hide your sources.
  --Albert Einstein
