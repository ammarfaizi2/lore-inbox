Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271973AbRIIOoF>; Sun, 9 Sep 2001 10:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271976AbRIIOnp>; Sun, 9 Sep 2001 10:43:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23812 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271973AbRIIOnd>; Sun, 9 Sep 2001 10:43:33 -0400
Subject: Re: Lockup with 2.4.9-ac9
To: gandalf@wlug.westbo.se (Martin Josefsson)
Date: Sun, 9 Sep 2001 15:47:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0109091547090.8049-100000@tux.rsn.bth.se> from "Martin Josefsson" at Sep 09, 2001 04:03:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15g5s4-00078f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I upgraded a server from 2.4.4-ac10 to 2.4.9-ac9 two days ago and I've
> been having problems with it since then (reverted to the old but working
> 2.4.4-ac10 for now).
> 
> The machine simply locks up and doesn't say a word, no Oops or
> anything, looks like a deadlock. 
> This happened 4 times yesterday and every time there was one user that was
> uploading a lot of data (a few GB) in quite high speeds to this LV.

The -ac tree has the LVM 1.0 code which is very new and updated reiserfs
code. That makes the combination trickier to debug. When it hangs do the
keyboard lights still work ? (that tells me if it hung irq off or on). In
the latter case enabling the NMI watchdog, and sysrq key may give useful
traces

Alan
