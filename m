Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbTDFT53 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 15:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbTDFT53 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 15:57:29 -0400
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:7172
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S263065AbTDFT52 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 15:57:28 -0400
From: "Shawn Starr" <spstarr@sh0n.net>
To: "'Shawn Starr'" <spstarr@sh0n.net>, "'Andrew Morton'" <akpm@digeo.com>
Cc: <roland@topspin.com>, <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: [BUG][2.5.66bk9+] - changes to timers still broken - we don't oops anymore
Date: Sun, 6 Apr 2003 16:09:01 -0400
Message-ID: <000001c2fc78$5f1df8b0$030aa8c0@unknown>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: 
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It just caused sshd to hang. I don't know why Here's what strace reports:

Sshd is stuck in 'D' and a child in zombie state. The machine has been up
for 2 days 18 hours 50 mins.

Somehow, although those changes fix the kernel from oopsing, its now causing
other tty issues somewhere.

Any ideas?

Shawn.

-----Original Message-----
From: Shawn Starr [mailto:spstarr@sh0n.net] 
Sent: Saturday, April 05, 2003 7:35 PM
To: 'Andrew Morton'
Cc: 'roland@topspin.com'; 'rml@tech9.net'; 'linux-kernel@vger.kernel.org'
Subject: RE: [OOPS][2.5.66bk9+] run_timer_softirq - IRQ Mishandlings - New
OOPS w/ timer

Andrew, since the new timer changes made, Things are looking solid so far.
We might want to begin adding things into BK-current no?

Sshd hasn't hung, ttys haven't hung either.

Shawn.




