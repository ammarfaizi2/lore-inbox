Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269586AbUICKEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269586AbUICKEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269599AbUICKCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:02:37 -0400
Received: from pop.gmx.de ([213.165.64.20]:25520 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269586AbUICKBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:01:39 -0400
X-Authenticated: #4399952
Date: Fri, 3 Sep 2004 12:14:05 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: lockup with voluntary preempt R0 and VP, KP, etc, disabled
Message-ID: <20040903121405.3d32beec@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops typo. now it should show up on lkml, too


Hi,

i can experience hard lockups when turning off all the VP stuff via the
/proc interface.

echo 0 > /proc/sys/kernel/hardirq_preemption
echo 0 > /proc/sys/kernel/softirq_preemption
echo 0 > /proc/sys/kernel/voluntary_preemption
echo 0 > /proc/sys/kernel/kernel_preemption
echo 0 > /proc/sys/kernel/trace_enabled

then do some audio work with jackd and the machine locks up in the next
3 or 4 minutes. How can i help in debugging this? I know only very
little about core dumps, etc, so it would be cool if anyone of you guys
can reproduce the lockup. Or tell me how to proceed..

flo

