Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbSLPLwy>; Mon, 16 Dec 2002 06:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266576AbSLPLwy>; Mon, 16 Dec 2002 06:52:54 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:37508 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S264688AbSLPLww>;
	Mon, 16 Dec 2002 06:52:52 -0500
Date: Mon, 16 Dec 2002 13:01:02 +0100 (CET)
From: Stephan van Hienen <ultra@a2000.nu>
To: linux-kernel@vger.kernel.org
cc: sparclinux@vger.kernel.org
Subject: Re: modprobe: Can't locate module personality-8
In-Reply-To: <Pine.LNX.4.50.0212121031450.23699-100000@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.50.0212161256270.17048-100000@ddx.a2000.nu>
References: <Pine.LNX.4.50.0212121031450.23699-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, Stephan van Hienen wrote:

> Dec 8 18:59:46 ddx modprobe: modprobe: Can't locate module personality-8
> Dec 8 18:59:46 ddx modprobe: modprobe: Can't locate module personality-8
> ..
> Dec 8 19:16:15 ddx modprobe: modprobe: Can't locate module personality-8
> Dec 8 19:16:55 ddx last message repeated 6 times
> Dec 8 19:17:06 ddx last message repeated 3 times
> ..
> Dec 11 10:06:12 ddx modprobe: modprobe: Can't locate module personality-8
> Dec 11 10:06:12 ddx modprobe: modprobe: Can't locate module personality-8
>
>
> Did i forget to compile something in the kernel ?
> (2.4.20 on sun ultrasparc)
> -

yesterday again :

Dec 14 03:46:30 ddx modprobe: modprobe: Can't locate module personality-8
Dec 14 03:47:11 ddx last message repeated 2 times
Dec 14 03:47:11 ddx modprobe: modprobe: Can't locate module personality-8

and now also 2 'new' errors :

Dec 14 03:54:18 ddx modprobe: modprobe: Can't locate module block-major-8
Dec 14 03:54:28 ddx modprobe: modprobe: Can't locate module block-major-8
Dec 14 03:55:32 ddx kernel:  hdc:
Dec 14 03:55:34 ddx kernel:  hdc:

(i think i runned fdisk at this time on /dec/hdc)


I don't have any modules compiled (all drivers inside kernel)
and i don't have /etc/modules.conf (someone told me that personality-8
could be an alias inside this config)

Can someone explain these 'errors' ?
