Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265821AbRF2JvW>; Fri, 29 Jun 2001 05:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265824AbRF2JvM>; Fri, 29 Jun 2001 05:51:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59140 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265821AbRF2Ju6>; Fri, 29 Jun 2001 05:50:58 -0400
Subject: Re: O_DIRECT please; Sybase 12.5
To: dank@kegel.com (Dan Kegel)
Date: Fri, 29 Jun 2001 10:50:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3B3C4CB4.6B3D2B2F@kegel.com> from "Dan Kegel" at Jun 29, 2001 02:39:00 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fuul-0008SJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the boss say "If Linux makes Sybase go through the page cache on
> reads, maybe we'll just have to switch to Solaris.  That's
> a serious performance problem."

Thats something you'd have to benchmark. It depends on a very large number
of factors including whether the database uses mmap, the average I/O size
and the like

> It supports raw partitions, which is good; that might satisfy my
> boss (although the administration will be a pain, and I'm not
> sure whether it's really supported by Dell RAID devices).
> I'd prefer O_DIRECT :-(

We already support raw direct I/O to devices themselves so they should support
that - if not then Oracle I believe already does.

