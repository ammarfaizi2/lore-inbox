Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292855AbSDXIJE>; Wed, 24 Apr 2002 04:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292857AbSDXIJD>; Wed, 24 Apr 2002 04:09:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24842 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292855AbSDXIJD>; Wed, 24 Apr 2002 04:09:03 -0400
Subject: Re: your mail
To: zghuo@gatekeeper.ncic.ac.cn (Huo Zhigang)
Date: Wed, 24 Apr 2002 09:27:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <7754BE2716BF.AAAE8A@gatekeeper.ncic.ac.cn> from "Huo Zhigang" at Apr 24, 2002 03:55:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E170I7b-000254-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >INIT: Switching to runlevel: 6
> >INIT: Send processes the TERM signal
> >Unable to handle kernel NULL pointer dereference
>   
>   What's wrong with my machines?  They are all running linux-2.2.18(SMP-supported) with a kernel module which is a driver of Myricom NIC M3S-PCI64C-2 written by my group.
>   Thank you in advance 8-)

If you boot the machije without your driver, then reboot does the
same happen ? If not then it may well be your driver has an error but only
when it closes down
