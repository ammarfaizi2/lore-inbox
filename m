Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTAaQ6W>; Fri, 31 Jan 2003 11:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTAaQ6W>; Fri, 31 Jan 2003 11:58:22 -0500
Received: from soul.helsinki.fi ([128.214.3.1]:26899 "EHLO soul.helsinki.fi")
	by vger.kernel.org with ESMTP id <S261463AbTAaQ6W>;
	Fri, 31 Jan 2003 11:58:22 -0500
Date: Fri, 31 Jan 2003 19:07:45 +0200 (EET)
From: Mikael Johansson <mpjohans@pcu.helsinki.fi>
X-X-Sender: mpjohans@soul.helsinki.fi
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: sched_runqueue.h missing: 2.4.21pre4-ac1 
In-Reply-To: <200301311430.h0VEUKr31316@devserv.devel.redhat.com>
Message-ID: <Pine.OSF.4.51.0301311900460.83374@soul.helsinki.fi>
References: <200301311430.h0VEUKr31316@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Alan and All!

Tried to compile 2.4.21-pre4-ac1, got the following error message:
process.c:33: linux/sched_runqueue.h: No such file or directory
make[1]: *** [process.o] Error 1
make: *** [_dir_arch/alpha/kernel] Error 2

So the file sched_runqueue.h requested by */arch/alpha/kernel/process.c is
missing on the system (checked it). Where might I find it?

Machine: Alpha DP264/Tsunami with 2*EV67 SMP, running Debian 3.0r1

Have a nice weekend,
    Mikael J.
    http://www.helsinki.fi/~mpjohans/
