Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276275AbRJGKMH>; Sun, 7 Oct 2001 06:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276278AbRJGKL5>; Sun, 7 Oct 2001 06:11:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40452 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276275AbRJGKLs>; Sun, 7 Oct 2001 06:11:48 -0400
Subject: Re: eepro100 net drivers
To: acc@acc.hn.org (acc)
Date: Sun, 7 Oct 2001 11:17:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011007120208.5a426ef2.acc@acc.hn.org> from "acc" at Oct 07, 2001 12:02:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qB01-0005Qh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have noticed that I only have this problem when my X is
> running. When my X is shutdown I dont have any problems.
> I downloaded and tested the latest stable kernel 2.4.10, but
> it still dont work.
> 
> I havn't found any solution for this problem, does anyone
> known what the problem is ?

Intel no doubt have a lovely list of errata but they aren't sharing them.

The -ac tree eepro100.c does have a couple of fixes I've now sent on to 
Linus to do with needed delays and a workaround for a problem with one
chip variant when running 10Mbit half duplex.

That driver might help. If you want to test it you only need to apply
the drivers/net/eepro100* part of the -ac patch just for that.

Alan
