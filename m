Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130276AbRBZOeh>; Mon, 26 Feb 2001 09:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130356AbRBZOcB>; Mon, 26 Feb 2001 09:32:01 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130299AbRBZOaI>;
	Mon, 26 Feb 2001 09:30:08 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 26 Feb 2001 10:36:54 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.2.18: static rtc_lock in nvram.c
CC: linux-kernel@vger.kernel.org
Message-ID: <3A9A31C5.22343.9BE580@localhost>
In-Reply-To: <3A9A0AF9.17727.45317@localhost> from "Ulrich Windl" at Feb 26, 2001 07:51:22 AM
In-Reply-To: <E14XK2K-0000sY-00@the-village.bc.nu>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Feb 2001, at 9:33, Alan Cox wrote:

> > browsing the sources for some problem I wondered why nvram.c uses a 
> > static spinlock named rtc_lock, hiding the global one.
> 
> It only does that for the atari, where the driver isnt used by other things

Hmm.. are there different nvram.c drivers? I noticed that SuSE 7.1 
loads that driver in i386....

Also doesn't look a lot like Atari:
 * This driver allows you to access the contents of the non-volatile 
memory in
 * the mc146818rtc.h real-time clock. This chip is built into all PCs 
and into
 * many Atari machines. In the former it's called "CMOS-RAM", in the 
latter
 * "NVRAM" (NV stands for non-volatile).


Regards,
Ulrich

