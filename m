Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130236AbRBZOem>; Mon, 26 Feb 2001 09:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130404AbRBZObk>; Mon, 26 Feb 2001 09:31:40 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130288AbRBZO3y>;
	Mon, 26 Feb 2001 09:29:54 -0500
Subject: Re: 2.2.18: static rtc_lock in nvram.c
To: Ulrich.Windl@rz.uni-regensburg.de (Ulrich Windl)
Date: Mon, 26 Feb 2001 09:44:35 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3A9A31C5.22343.9BE580@localhost> from "Ulrich Windl" at Feb 26, 2001 10:36:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XKCr-0000tY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It only does that for the atari, where the driver isnt used by other things
> 
> Hmm.. are there different nvram.c drivers? I noticed that SuSE 7.1 
> loads that driver in i386....

Read carefully

>  * This driver allows you to access the contents of the non-volatile 
> memory in
>  * the mc146818rtc.h real-time clock. This chip is built into all PCs 
> and into
>  * many Atari machines. In the former it's called "CMOS-RAM", in the 
> latter
>  * "NVRAM" (NV stands for non-volatile).

The 

static spinlock_t

is in the ATARI specific section

