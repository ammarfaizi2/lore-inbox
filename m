Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268909AbRHPWI0>; Thu, 16 Aug 2001 18:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268905AbRHPWIF>; Thu, 16 Aug 2001 18:08:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48904 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268903AbRHPWIB>; Thu, 16 Aug 2001 18:08:01 -0400
Subject: Re: Dual 1.7 GHz Xeon -- slow, interrupts not balance, etc
To: ossama@doc.ece.uci.edu (Ossama Othman)
Date: Thu, 16 Aug 2001 23:10:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, ossama@uci.edu
In-Reply-To: <20010816145446.B7801@ece.uci.edu> from "Ossama Othman" at Aug 16, 2001 02:54:46 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XVLG-0006AI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been trying to figure out why two Dell Precision 530 Workstations
> (dual 1.7 GHZ Intel Xeon) we just purchased running Linux (I installed
> Debian with 2.4.7 and 2.4.8 kernels) are much slower than expected.
> Note that they were just as slow with the vanilla RedHat 7.1
> installation they were shipped with.  Our dual 1 GHz PIII is just as
> fast as they are.   I'm not sure if it's a hardware or kernel

If you look at the figures from the various benchmarking sites that doesnt
sound unexpected. If you can recode your applications (eg if its a complex
analysis problem) to use SSE2 and the like you may well get big speed ups

> hardware.  No SCSI, all IDE.  400 MHz RDRAM, etc.  However, the PIII
> box only has 512MB RAM compared to the 1 GB of RAM the Xeon boxes
> have.

The impact of that depends entirely on your application

> Any ideas why CPU1 isn't getting any interrupts?  Incidentally,
> interrupts appear to be fairly well balanced on our PIII box.

Do the boot messages ay anothing about this ?

