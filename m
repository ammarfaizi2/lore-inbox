Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbRENWZY>; Mon, 14 May 2001 18:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262537AbRENWZN>; Mon, 14 May 2001 18:25:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42506 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262528AbRENWZD>; Mon, 14 May 2001 18:25:03 -0400
Subject: Re: driver/media/video/buz.c breaks build?
To: bill@ataras.com (Bill Ataras)
Date: Mon, 14 May 2001 23:21:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B004A9F.B616597A@ataras.com> from "Bill Ataras" at May 14, 2001 03:14:07 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zQiR-0001YQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> buz.c references KMALLOC_MAXSIZE which appears to be no longer defined.
> In order to build it, I've had to re-add this define to slab.h.
> 
> Saw it in 2.4.3. Still in 2.4.4

buz.c is dead. Use the -ac kernel and the ZR36067 driver

