Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbTAVWHz>; Wed, 22 Jan 2003 17:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTAVWHz>; Wed, 22 Jan 2003 17:07:55 -0500
Received: from web9806.mail.yahoo.com ([216.136.129.29]:42508 "HELO
	web9806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263899AbTAVWHz>; Wed, 22 Jan 2003 17:07:55 -0500
Message-ID: <20030122221703.42913.qmail@web9806.mail.yahoo.com>
Date: Wed, 22 Jan 2003 14:17:03 -0800 (PST)
From: Tom Sanders <developer_linux@yahoo.com>
Subject: Linux application level timers?
To: redhat-list@redhat.com, linux-kernel@vger.kernel.org,
       redhat-devel-list@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing an application server which receives
requests from other applications. For each request
received, I want to start a timer so that I can fail
the application request if it could not be completed
in max specified time.

Which Linux timer facility can be used for this?

I have checked out alarm() and signal() system calls,
but these calls doesn't take an argument, so its not
possible to associate application request with the
matured alarm.

Any inputs?

Thanks in advance,
Tom

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
