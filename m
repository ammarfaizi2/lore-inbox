Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265223AbUEUX6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbUEUX6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUEUXwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:52:20 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:6157 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264488AbUEUX3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:29:51 -0400
Message-ID: <40AE4493.3090202@techsource.com>
Date: Fri, 21 May 2004 14:04:03 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OT] Linux stability despite unstable hardware
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had some issues recently with memory errors when using aggressive 
memory timings.  Although memory tests (like memtest86) pass fine, gcc 
would tend to crash and would generate incorrect code when compiling 
other things.  Gcc couldn't even build itself properly under those 
conditions.

The really interesting thing is that the Linux kernel was totally
unaffected.  Compiling the Linux kernel is often thought of as a
stressful thing for a system, yet compiling a kernel with a broken gcc
on a system with intermittent memory errors goes through error free, and
the kernel is 100% stable when running.

But until the memory errors were fixed, things like KDE wouldn't build
without gcc crashing.

So, what is it about Linux that makes it build properly with a broken
GCC and run perfectly despite memory errors?




