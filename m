Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUBPNLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265513AbUBPNLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:11:31 -0500
Received: from ddc.ilcddc.com ([12.35.229.4]:57095 "EHLO ddcnyntd.ddc-ny.com")
	by vger.kernel.org with ESMTP id S265502AbUBPNL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:11:29 -0500
Message-ID: <89760D3F308BD41183B000508BAFAC4104B16F79@DDCNYNTD>
From: RANDAZZO@ddc-web.com
To: linux-kernel@vger.kernel.org
Subject: what to use (sem/spinlock/etc)....
Date: Mon, 16 Feb 2004 08:10:16 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a register on my hardware that I write to to increment a counter....
..all I want to do is make sure that only one "task" writes at a time, 
thus to not corrupt the value......

=EXAMPLE

Task A
- Write new Value to hardware
- Increment Hardware counter
- DONE

Task B
- Write new Value to hardware
- Increment Hardware counter
- DONE

..This will most likely not occur in a inthandler, but may....

...I have to make sure that Task A is "done" before "Task B" or any others
can do their writing....

...any opinion of what I should use....

 
"This message may contain company proprietary information. If you are not
the intended recipient, any disclosure, copying, distribution or reliance on
the contents of this message is prohibited. If you received this message in
error, please delete and notify me."

