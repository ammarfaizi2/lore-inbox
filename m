Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbQLMB7B>; Tue, 12 Dec 2000 20:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbQLMB6v>; Tue, 12 Dec 2000 20:58:51 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:26165 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S129385AbQLMB6k>; Tue, 12 Dec 2000 20:58:40 -0500
Date: Tue, 12 Dec 2000 20:28:11 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Igmar Palsenberg <maillist@chello.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18 release notes
In-Reply-To: <Pine.LNX.4.21.0012130223560.31563-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.4.10.10012122026180.28197-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - metrics -- L1 cacheline size is the important one: you align array
...
> Anyone can give me some pointers on how this is done runtime ? (name of
> the .c file is fine).

kernel/sched.c:aligned_data.  as mentioned elsewhere, 
the correct alignment is not necessarily L1 linesize.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
