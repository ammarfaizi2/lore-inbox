Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUJNQhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUJNQhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 12:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUJNQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 12:37:14 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:41600 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266741AbUJNQgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 12:36:47 -0400
Message-ID: <416EAB15.6030304@t-online.de>
Date: Thu, 14 Oct 2004 18:36:37 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4: Kernel BUG at timer:414
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: TWu-wQZvYewFVx9ppVKhk6rL1nK7fo6YpfQGWc36nmj3kJubFbTJrY
X-TOI-MSGID: 0448c57a-3c64-41a7-b556-e4adb839d37b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I got a kernel panic on amd64:


Kernel BUG at timer:414
invalid operand: 0000 [1] PREEMPT
CPU 0
Modules linked in: ...
Pid: 3711, comm: mktemp Not tainted 2.6.9-rc4
RIP: 0010: ...{cascade+46}
:
:
Process mktemp (pid 3711, ...)
Stack: ...
Call Trace: <IRQ>
             <...>{run_timer_softirq}
             <...>{__do_softirq+83}
             <...>{do_softirq+53}
             <...>{do_IRQ+383}
             <...>{ret_from_intr+0}
             <EOI>
Code 0f 0b 66 b1 2f 80 ff ff ff ff9e 01 66 66 90 66 66 90 48 8b
RIP <...>{cascade+46}
  <0> Kernel panic - not syncing: Aiee, killing interrupt handler!


Please excuse that I did not write down every hex code
of the error message.


Regards

Harri
