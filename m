Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132227AbRAPShW>; Tue, 16 Jan 2001 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132367AbRAPShN>; Tue, 16 Jan 2001 13:37:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:25356 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132227AbRAPSg6>; Tue, 16 Jan 2001 13:36:58 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: kernel BUG with 2.4.1-pre7 reiserfs
Date: 16 Jan 2001 10:36:43 -0800
Organization: Transmeta Corporation
Message-ID: <9424br$j3h$1@penguin.transmeta.com>
In-Reply-To: <20010116192041.A466@borg.pp.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010116192041.A466@borg.pp.se>,
Jakob Borg  <jakob@borg.pp.se> wrote:
>Hi,
>
>I recently got this in my logs after moving /home to reiserfs. It is a plain
>2.4.1-pre7 SMP system (.config attached).
>
>Jan 16 19:15:02 narayan kernel: journal_begin called without kernel lock held
>Jan 16 19:15:02 narayan kernel: kernel BUG at journal.c:423!
>Jan 16 19:15:02 narayan kernel: CPU:   0
>
>I seem to remember more possibly useful information scrolling by my screen,
>but it seems to not have made it to the logs, and I will shut down and fsck
>the filesystem now...

It really needs the stack-trace to debug this sanely (along with
translations of what the hex numbers are - see the bugreporting
documentation in the kernel source tree). 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
