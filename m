Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272528AbRIWSMN>; Sun, 23 Sep 2001 14:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272540AbRIWSMD>; Sun, 23 Sep 2001 14:12:03 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:33201 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272528AbRIWSLw>; Sun, 23 Sep 2001 14:11:52 -0400
Date: Sun, 23 Sep 2001 14:12:18 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200109231812.f8NICIt20979@devserv.devel.redhat.com>
To: zefram@fysh.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
In-Reply-To: <mailman.1001266380.13783.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1001266380.13783.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Theoretically every program should be able to determine which erase
> character to accept by looking at terminfo,

Rubbish. Programs get their erase characters from termios(3).

> One of the programs that exhibits the ^H/^? problem is the tty
> line discipline in the Linux kernel.

Read man pages for stty(1) and tset(1).

-- Pete
