Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVB1Pfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVB1Pfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVB1Pfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:35:55 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:14265 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261651AbVB1Pft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:35:49 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>,
       linux-kernel@vger.kernel.org
Subject: Re: need for user mode linux
Date: Mon, 28 Feb 2005 15:35:47 +0000
Message-Id: <022820051535.19606.42233A53000917EE00004C96220073484000009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> hai all,
>      I am a newbie to linux kernel module programming.I am going to work on
>   driver modification or calling some programs from driver. I heard about 
> usermode linux and its uses but I don't know the practical use of usermode 
> linux. Is it needed for me. How 
> it will be useful.Ofcourse, it need to be my personal decision, but I am 
> seeking decision or hints from experts like u.

UML - it is what it sounds like. Run Linux kernel as a user mode program inside a regular Linux operating system. It is generally good to use in situations as yours - learning and experimenting with kernel code without screwing up the hardware and host operating system. So you could do all your development and debugging on UML for instance and if it crashes due to your program error, no big deal just restart UML.

That being said, I am not sure if UML is in usable state with current kernels - Last time I tried I couldn't get it to run with 2.6.10 kernel.

You might want to check http://www.colinux.org - It is similar to UML, but instead of running Linux-under-Linux you run Linux-under-Windows. It is fairly simple to install and various distro images are available. Try out the documentation for colinux.

Parag



