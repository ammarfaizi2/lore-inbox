Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289621AbSAOTsd>; Tue, 15 Jan 2002 14:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289620AbSAOTrc>; Tue, 15 Jan 2002 14:47:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32516 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289612AbSAOTrC>; Tue, 15 Jan 2002 14:47:02 -0500
Subject: Re: arpd not working in 2.4.17 or 2.5.1
To: amit.gupta@amd.com (Amit Gupta)
Date: Tue, 15 Jan 2002 19:58:46 +0000 (GMT)
Cc: kernel@Expansa.sns.it (Luigi Genoni), linux-kernel@vger.kernel.org
In-Reply-To: <3C447C15.A9673272@cmdmail.amd.com> from "Amit Gupta" at Jan 15, 2002 10:59:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QZjK-00061Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But arp>1024 is Very Important, else linux will never be able to talk to more
> than 1024 clients !
> 
> Linux is my favourite and I wonder if this limit will kill linux for the race
> with Solaris/M$ server market. So pls save me :) and help neighour.c/network
> layer in new kernel.

ARP applies for local links only. So you need a network you are actively
talking to 1024 different hosts directly on. Furthermore all the
config items should now be soft anyway. Want more, enable more.
