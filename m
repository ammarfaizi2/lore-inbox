Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262153AbREPXvC>; Wed, 16 May 2001 19:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262149AbREPXuq>; Wed, 16 May 2001 19:50:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47117 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262153AbREPXuO>; Wed, 16 May 2001 19:50:14 -0400
Subject: Re: VIA/PDC/Athlon
To: jlaako@pp.htv.fi (Jussi Laako)
Date: Thu, 17 May 2001 00:47:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B02B824.6FAF5125@pp.htv.fi> from "Jussi Laako" at May 16, 2001 08:25:56 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150B0Z-0004f8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tested 2.4.4-ac9 today on A7V133 machine. It booted up, but can't stand
> any load. It will deadlock (without oops) when the network/disk system faces
> any load.

Let me guess 'ide=nodma' fixes that ?

> There is also some new bug in VIA IDE driver. It misdetects cable as 80-w
> when it's only 40-w and causes some CRC errors and speed dropping. Some

Since when - the VIA driver in -ac has not changed for a very long time

> older kernels correctly detected the cable as 40-w and used UDMA33, this one
> tries to use UDMA100 and fails (of course). Is there any way to force cable
> detection to 40-w?

it shouldnt ever misdetect - thats a bug. 

