Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSGVEI6>; Mon, 22 Jul 2002 00:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSGVEI6>; Mon, 22 Jul 2002 00:08:58 -0400
Received: from moutvdomng0.kundenserver.de ([195.20.224.130]:41960 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S315946AbSGVEI5>; Mon, 22 Jul 2002 00:08:57 -0400
Date: Sun, 21 Jul 2002 22:11:38 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Rusty Russell <rusty@rustcorp.com.au>
cc: trivial@rustcorp.com.au, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>
Subject: Re: [TRIVIAL] Remove stupid attribution.
In-Reply-To: <20020722034447.7D9604352@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0207212209480.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 22 Jul 2002, Rusty Russell wrote:
> A couple of tiny patches and several mails to Ingo does not justify a
> mention in the comments.  If everyone did that, the kernel size would
> double.

I prefer this version:

diff -Nur linux-2.5.27/kernel/sched.c thunder-2.5/kernel/sched.c
--- linux-2.5.27/kernel/sched.c	Sun Jul 21 17:43:10 2002
+++ thunder-2.5/kernel/sched.c	Mon Jul 22 12:22:15 2002
@@ -13,7 +13,7 @@
  *		hybrid priority-list and round-robin design with
  *		an array-switch method of distributing timeslices
  *		and per-CPU runqueues.  Additional code by Davide
- *		Libenzi, Robert Love, and Rusty Russell.
+ *		Libenzi and Robert Love.
  */
 
 #include <linux/mm.h>

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

