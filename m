Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTFKTpP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFKTpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:45:15 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:42417 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S263705AbTFKTpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:45:11 -0400
From: Artemio <artemio@artemio.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP question
Date: Wed, 11 Jun 2003 22:52:40 +0300
User-Agent: KMail/1.5
References: <200306112043.11923.artemio@artemio.net> <3EE7852C.2050605@rackable.com>
In-Reply-To: <3EE7852C.2050605@rackable.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306112252.40979.artemio@artemio.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK guys, thanks for all your replies.

What I have is the following.

I'm building a hard real-time Linux (RTLinux) system on a 2x Xeon machine. If 
I compile and run a 2.4.18 kernel with SMP support, rtlinux hangs the 
machine. However, with SMP disabled, rtlinux and all it's hard-realtime 
applications runs okay.

So, I have to deside between these two:

 - Run rtlinux and hard-realtime applications on a kernel without SMP support. 
How much performance will I loose this way? Is SMP *THAT* critical? 

 - Run all tasks in a usual way, no hard realtime, but with SMP support.


What would you suggest?


Also, if I turn hyperthreading off, how will it influence the system with SMP 
support? Without SMP support?



Thanks!


Artemio.
