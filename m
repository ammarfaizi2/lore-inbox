Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVCJERa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVCJERa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVCJEPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:15:20 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:59404 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261688AbVCJEM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 23:12:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=j5g4Zz4jwoFZknC4dtkvKoTkecSczugc1GbI8YMsHhTdHLuGX/nx0PpciVQA4f+zHecQS1zYVROSJ3DCvKbs/pbCSj3HgS/m3y6yhJcLYWoPj0fSIyjvBlU01A2KH+eHa19fNOAh3X9SKOj62eEaKNgUh1V5vnMt04KtXgdg19Q=
Message-ID: <21d7e9970503092012475049db@mail.gmail.com>
Date: Thu, 10 Mar 2005 15:12:57 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sched_setscheduler and pids/threads
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm a bit confused over 2.6 threading with respects to real time
scheduling settings...

In 2.6 all my threads appear as a single PID, if I use chrt -p <pid>
will it set the scheduling priority for my main thread or for all
threads in the application?

Can I used the thread IDs from /proc/<pid>/task/ to chrt the other
threads in my app to different priorities?

Thanks,
Dave.
