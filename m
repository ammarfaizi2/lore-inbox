Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbSK2Xaq>; Fri, 29 Nov 2002 18:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbSK2Xaq>; Fri, 29 Nov 2002 18:30:46 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:25548 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S267179AbSK2Xao>;
	Fri, 29 Nov 2002 18:30:44 -0500
Date: Sat, 30 Nov 2002 00:38:07 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Con Kolivas <conman@kolivas.net>
Subject: [PATCHSET] Linux 2.4.20-jam0
Message-ID: <20021129233807.GA1610@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

New announcement of the -jam patches. While we all await for a real
-aa1 from Andrea, here goes an -jam0 (ie, not -jam1), with -aa
patch ported. It runs fine on my box.

Additions since last release (see README for credits...):

- reverted the fast-pte part of -aa. Still have to try again
  to see if it is more stable now.
- force-inline patch.
- 4M queue size for block writes
- P4 prefetching
- Orlov inode allocator for 2.4
- BProc 3.2.3

(btw, I have bee looking for orlov for ext2 - it exists ? -
 and htree for ext2/3. Any pointers ? )

As always, get it at:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.20-jam0.tar.gz
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.20-jam0/

Enjoy !!

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam0 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
