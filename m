Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTKMLNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263956AbTKMLNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:13:07 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:3989 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S263953AbTKMLNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:13:04 -0500
Date: Thu, 13 Nov 2003 13:12:58 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
Subject: 2.6.0test9 + 2 * P IV Xeon 2.4GHz with HT + SATA + RAID1 = scheduler
 problems
Message-ID: <Pine.LNX.4.58.0311131303500.4183@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I want to tell you that 2.6.0-test gets better and better. It works very
very well on several systems. Thank you very much, guys.

I have an server (like in the subject). The problem is that the scheduler
seems to behave weird. Sometimes a program just do nothing. There is no
disk activity, interrupts are a little over 1000, no disk requests,
context switches are ~40. The system is idle but it has work to do!
Can I provide more info?

I tried to put elevator=deadline and things seems worse.

If I'm not mistaken, the processes are in D state. Bt I'm not sure, I must
check again and right now I can't.

Also I suspect that scheduler doesn't pay special attention to virtual
(HT) processors. Is this true?

I have not seen this problem on other machines.

Thank you.

---
Catalin(ux) BOIE
catab@deuroconsult.ro
