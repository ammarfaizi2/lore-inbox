Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVGQMqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVGQMqQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 08:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVGQMqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 08:46:16 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:7121 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261274AbVGQMqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 08:46:15 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: rt-preempt and x86_64?
Date: Sun, 17 Jul 2005 13:46:11 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507171346.11377.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

(I searched the list for rt realtime x86_64 x86-64 before posting this, so I 
hope it's not a duplicate).

I've noticed -31 compiles without notable error or warning on x86-64, so I 
thought maybe it was a valid time to file a bug report about it not working.

The machine currently runs 2.6.12 but when booting with PREEMPT_RT mode on the 
same machine I get:

init[1]: segfault at ffffffff8010e9c4 rip ffffffff8010e9c4 rsp 
00007fffffe28018
[...]

Which repeats indefinitely (presumably the kernel tries repeatedly to spawn 
it). I've booted without quiet and a broken root= and the kernel doesn't seem 
to complain about ANYTHING, so this must be a bug.

Any ideas?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
