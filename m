Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757797AbWKXQJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797AbWKXQJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 11:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934505AbWKXQJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 11:09:31 -0500
Received: from mtiwmhc13.worldnet.att.net ([204.127.131.117]:54193 "EHLO
	mtiwmhc13.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1757797AbWKXQJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 11:09:30 -0500
Message-ID: <456718F6.8040902@lwfinger.net>
Date: Fri, 24 Nov 2006 10:08:22 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc5-mm1 progression
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since at least the 2.6.18 development kernels, my interactive sessions have sometimes been very 
sluggish whenever a cpu-intensive process is running. This has been so bad that the mouse is 
unresponsive. The system behaved as if it were swapping; however, swapfile usage is always 0. The 
system has 820 MB RAM. I have not reported this problem as I really couldn't quantify it due to its 
intermittent nature.

Recently, I needed to run 2.6.19-rc5-mm1 to check out a problem reported by a bcm43xx user. I found 
that even with a kernel build, a git pull, and a separate build running, the system was responsive 
for interactive tasks. I have not yet identified which of the -mm1 patches "fixes" the problem, but 
plan to do so. Is there the equivalent of 'git bisect' for the -mmX kernels?

Larry
