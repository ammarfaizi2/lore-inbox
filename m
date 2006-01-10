Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWAJM2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWAJM2V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWAJM2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:28:21 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:9124 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750754AbWAJM2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:28:21 -0500
Message-ID: <43C3BA46.F159E0CE@tv-sign.ru>
Date: Tue, 10 Jan 2006 16:44:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] rcu: misc cleanups
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is re-send of cleanups which where acked by Paul.

Patches 1-2 are unchanged and already applied to the git tree,
I am re-sending them just in case.

"[PATCH 3/3] rcu: join rcu_ctrlblk and rcu_state" was updated
to match kernel.org/git/, the only change is

-	____cacheline_maxaligned_in_smp
+	____cacheline_internodealigned_in_smp

Oleg.
