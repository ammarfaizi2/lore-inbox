Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317556AbSFIHuW>; Sun, 9 Jun 2002 03:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317572AbSFIHuV>; Sun, 9 Jun 2002 03:50:21 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:52493 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317556AbSFIHuV>; Sun, 9 Jun 2002 03:50:21 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <200206090709.g5979iK439624@saturn.cs.uml.edu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 09 Jun 2002 16:49:54 +0900
Message-ID: <87fzzwdh7h.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> Long ago, it was considered OK to use the kernel headers
> in app code. This is the case with Linux 2.0 and libc 5.
> (it used to be OK to symlink /usr/include/linux into an
> unmodified copy of the Linux kernel source)
> 
> There has been a weak effort to avoid breaking libc 5.
> 
> Using __KERNEL__ might make it easier to provide cleaned
> headers for user code.
> 
> There has been talk of removing __KERNEL__ usage from
> some of the header files.

So, are you going to remove __KERNEL__ stuff, although the program for
linux uses it? And are you going to fix program using it?

I don't want to do.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
