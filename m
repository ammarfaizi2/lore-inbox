Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbTDFUtW (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbTDFUtW (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:49:22 -0400
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:1028
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S263079AbTDFUtV (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 16:49:21 -0400
From: "Shawn Starr" <spstarr@sh0n.net>
To: "'Andrew Morton'" <akpm@digeo.com>
Cc: <roland@topspin.com>, <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [BUG][2.5.66bk9+] - changes to timers still broken - we don't oops anymore
Date: Sun, 6 Apr 2003 17:00:48 -0400
Message-ID: <000101c2fc7f$9e2e5d40$030aa8c0@unknown>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20030406133827.34bfbf93.akpm@digeo.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, the timer changes made caused sshd to hang It appears.

When it next does this I will sysctl+T and report the output.

It's still hard to track this problem, but at least its not causing the box
to hang anymore, so part of the problem is solved :-)

Shawn.

-----Original Message-----
From: Andrew Morton [mailto:akpm@digeo.com] 
Sent: Sunday, April 06, 2003 4:38 PM
To: Shawn Starr
Cc: spstarr@sh0n.net; roland@topspin.com; rml@tech9.net;
linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.5.66bk9+] - changes to timers still broken - we don't
oops anymore

"Shawn Starr" <spstarr@sh0n.net> wrote:
>
> It just caused sshd to hang.

What is "it"?

I receive rather a lot of email and am dependent on people helping me
out a bit with context.  I have lost the plot on this one.

> I don't know why Here's what strace reports:
> 
> Sshd is stuck in 'D' and a child in zombie state. The machine has been up
> for 2 days 18 hours 50 mins.

a sysrq-T trace here would help.


