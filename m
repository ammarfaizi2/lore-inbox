Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286319AbRLJRF5>; Mon, 10 Dec 2001 12:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286317AbRLJRFU>; Mon, 10 Dec 2001 12:05:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54537 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286313AbRLJRFB>; Mon, 10 Dec 2001 12:05:01 -0500
Subject: Re: [PATCH] Promise Ultra ATA 133 TX2 support
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Mon, 10 Dec 2001 17:14:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0112101719390.11051-200000@mustard.heime.net> from "Roy Sigurd Karlsbakk" at Dec 10, 2001 05:44:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DU0S-0002fC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I beleive these three lines are enough to allow for promise udma133/tx2
> support. It looks like they've just increased the version number... Is
> this old news?

For the UDMA 133 modes I believe you need Andre's LBA48 patch, or the new
one he's said he'll be releasing soon. With luck as soon as the 2.5 bio code
is stable that can go into the 2.5 tree so we get 160Gb disks at rocket
speed.

Alan
