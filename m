Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293627AbSCPAtd>; Fri, 15 Mar 2002 19:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293628AbSCPAtW>; Fri, 15 Mar 2002 19:49:22 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:39685 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S293627AbSCPAtM>; Fri, 15 Mar 2002 19:49:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: bit ops on unsigned long?
Date: Sat, 16 Mar 2002 11:52:28 +1100
Message-Id: <E16m2Qu-0007mc-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	nfs is broken in 2.5 ATM because it does set_bit on an "int".
Can be *please* just bite the bullet and change the prototype on these
ops so we stop seeing the same mistakes over and over?

This and "copy_from_user doesn't return -EFAULT" are the two classic
trivial kernel bugs.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
