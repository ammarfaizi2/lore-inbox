Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273702AbRIQVhy>; Mon, 17 Sep 2001 17:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273703AbRIQVhe>; Mon, 17 Sep 2001 17:37:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51728 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273702AbRIQVh3>; Mon, 17 Sep 2001 17:37:29 -0400
Subject: Re: Reading Windows CD on Linux 2.4.6
To: blinn@MissionCriticalLinux.com (Bruce Blinn)
Date: Mon, 17 Sep 2001 22:41:20 +0100 (BST)
Cc: root@chaos.analogic.com,
        masu@cr213096-a.rchrd1.on.wave.home.com (Masoud Sharbiani),
        linux-kernel@vger.kernel.org
In-Reply-To: <3BA669A8.812D381D@MissionCriticalLinux.com> from "Bruce Blinn" at Sep 17, 2001 02:22:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15j68m-0007wc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here are the results of the methods that were suggested for producing a
> CD image.  They all seem to fail at the same place because the resulting
> file is the same size.
> 
> 	# dd if=/dev/cdrom of=/tmp/cd1.iso
> 	dd: /dev/cdrom: Input/output error
> 	1440+0 records in
> 	1440+0 records out

Bad CD image - or that is all the data on it. If its bad blocks you can tell
dd to continue past bad blocks and pad them with zero - handy for rescueing
uncompressed tape backups
