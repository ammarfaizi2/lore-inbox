Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269794AbTGKFaB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 01:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269793AbTGKFaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 01:30:01 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:19964 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S269794AbTGKFaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 01:30:00 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: ptrinfo function in slab.c
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 11 Jul 2003 14:44:14 +0900
Message-ID: <buollv562j5.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see that you added a function `ptrinfo' in mm/slab.c recently, which
doesn't compile nicely on a no-mmu arch.

Locally I just deleted it, as it seems to have no callers, but perhaps
it could be better moved to one of the mm/ files that only gets
compiled for CONFIG_MMU?

Thanks,

-Miles
-- 
"I distrust a research person who is always obviously busy on a task."
   --Robert Frosch, VP, GM Research
