Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269630AbRHAEWy>; Wed, 1 Aug 2001 00:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269633AbRHAEWo>; Wed, 1 Aug 2001 00:22:44 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:40847 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S269630AbRHAEWf>; Wed, 1 Aug 2001 00:22:35 -0400
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re[4]: cannot copy files larger than 40 MB from CD
In-Reply-To: <Pine.LNX.4.31.0107311656420.10245-100000@linux.local> <200108010004.CAA1062359@mail.takas.lt>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 01 Aug 2001 00:19:06 -0400
In-Reply-To: Nerijus Baliunas's message of "Wed, 1 Aug 2001 02:03:36 +0200 (EET)"
Message-ID: <m2elqwtnt1.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>>>>> "Nerijus" == Nerijus Baliunas <nerijus@users.sourceforge.net> writes:
[snip]
 Nerijus> As I remember Alan said recent 2.4 kernels should be
 Nerijus> compiled with gcc 2.95 or 2.96 (preferably?).

Huh?  Might I recommend this (or some variant)?

bb,
Bill Pringlemeir

--- /usr/src/linux/Documentation/Changes	Wed Jun 27 16:37:05 2001
+++ Changes.new	Wed Aug  1 00:12:53 2001
@@ -70,9 +70,7 @@
 necessarily to users of other CPUs. Users of other CPUs should obtain
 information about their gcc version requirements from another source.
 
-The recommended compiler for the kernel is egcs 1.1.2 (gcc 2.91.66), and it
-should be used when you need absolute stability. You may use gcc 2.95.x
-instead if you wish, although it may cause problems. Later versions of gcc
+The recommended compiler for the kernel is gcc 2.95.x. Later versions of gcc
 have not received much testing for Linux kernel compilation, and there are
 almost certainly bugs (mainly, but not exclusively, in the kernel) that
 will need to be fixed in order to use these compilers. In any case, using


