Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSCKTZI>; Mon, 11 Mar 2002 14:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289226AbSCKTY6>; Mon, 11 Mar 2002 14:24:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24077 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289046AbSCKTYs>; Mon, 11 Mar 2002 14:24:48 -0500
Subject: Re: [PATCH] 2.5.6 IDE 19
To: aia21@cus.cam.ac.uk (Anton Altaparmakov)
Date: Mon, 11 Mar 2002 19:39:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        andre@linuxdiskcert.org (Andre Hedrick),
        dalecki@evision-ventures.com (Martin Dalecki),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.SOL.3.96.1020311180113.13428A-100000@libra.cus.cam.ac.uk> from "Anton Altaparmakov" at Mar 11, 2002 06:05:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kVdS-0001U0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The idea behind native DFT is to be able to perform drive diagnostics from
> within the OS without rebooting with a DOS disk and tying up the system
> for hours during the checks. The advantages of this combined with IDE/SCSI
> hot swap are strikingly obvious...

So providing we have a properly generic "issue IDE command from user space"
do we need any more kernel magic for this ?
