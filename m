Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbTIGGFd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 02:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTIGGFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 02:05:33 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:37638
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262296AbTIGGFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 02:05:30 -0400
Message-ID: <3F5ACA93.6020302@cyberone.com.au>
Date: Sun, 07 Sep 2003 16:05:07 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Greg Wooledge <greg@wooledge.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: moving a window makes the system 'hang' until button is released
References: <20030906205320.GA21490@pegasus.wooledge.org>
In-Reply-To: <20030906205320.GA21490@pegasus.wooledge.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg Wooledge wrote:

>[1.] One line summary of the problem:    
>Dragging a window in X makes the system "hang" until button is released.
>
>[2.] Full description of the problem/report:
>"Hang" means xmms's sound output stops, and if I'm running something
>like "while :; do echo hi; sleep 1; done" in a different window, that
>also stops writing "hi" until I release the mouse button.  (Then I
>get a whole bunch of them all at once.)  This seems to rule out ALSA
>being the cause, which was originally my first thought.
>
>I've tried with and without CONFIG_PREEMPT enabled.  I've tried changing
>X to be un-niced.  I've tried applying the patch-test4-O20int patch from
>Con Kolivas.  That last patch seems to have increased the time it takes
>for the problem to kick in (it's on the order of 5 seconds now instead
>of 3 seconds), but it didn't fix it.
>

Hi Greg,
Can you give my scheduler a try if you have time?


