Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276097AbRJUOM1>; Sun, 21 Oct 2001 10:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276099AbRJUOMR>; Sun, 21 Oct 2001 10:12:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:528 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276097AbRJUOME>; Sun, 21 Oct 2001 10:12:04 -0400
Subject: Re: The new X-Kernel !
To: linux@sneulv.dk (Allan Sandfeld)
Date: Sun, 21 Oct 2001 15:19:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15vFoM-0000D7-00@Princess> from "Allan Sandfeld" at Oct 21, 2001 12:26:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vJRN-0006Sm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have the AGP, DRM and framebuffer drivers in the kernel anyway. It would 
> make sense to do all the autodetection in kernelspace, and let the info be 
> available to the X-server. I would love to kill all the hardware specific 
> stuff in /etc/XF86Config, especially the keyboard and mouse stuff that 
> belongs in or near the kernel.

Quite the reverse. The handling for mice/keyboards and dynamic changes of
keyboard/mouse need to be in X11.

Alan
