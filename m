Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266020AbUEUV5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266020AbUEUV5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 17:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266038AbUEUV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 17:57:13 -0400
Received: from bay1-f135.bay1.hotmail.com ([65.54.245.135]:36356 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266020AbUEUV5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 17:57:10 -0400
X-Originating-IP: [209.208.48.130]
X-Originating-Email: [theosib@hotmail.com]
From: "Timothy Miller" <theosib@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: miller@techsource.com
Subject: [OT] Linux stability despite unstable hardware
Date: Fri, 21 May 2004 17:57:09 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F135u0T4Dk5Je6000264da@hotmail.com>
X-OriginalArrivalTime: 21 May 2004 21:57:10.0193 (UTC) FILETIME=[90DB3210:01C43F7E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had some issues recently with memory errors when using aggressive 
memory timings.  Although memory tests pass fine, gcc would tend to crash 
and would generate incorrect code when compiling other things. Gcc couldn't 
even build itself properly under those conditions.

The really interesting thing is that the Linux kernel was totally 
unaffected.  Compiling the Linux kernel is often thought of as a stressful 
thing for a system, yet compiling a kernel with a broken gcc on a system 
with intermittent memory errors goes through error free, and the kernel is 
100% stable when running.

But until the memory errors were fixed, things like KDE wouldn't build 
without gcc crashing.

So, what is it about Linux that makes it build properly with a broken GCC 
and run perfectly despite memory errors?

_________________________________________________________________
Watch LIVE baseball games on your computer with MLB.TV, included with MSN 
Premium! http://join.msn.click-url.com/go/onm00200439ave/direct/01/

