Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283204AbRL1Qag>; Fri, 28 Dec 2001 11:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282547AbRL1Qa0>; Fri, 28 Dec 2001 11:30:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42249 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282067AbRL1QaP>; Fri, 28 Dec 2001 11:30:15 -0500
Subject: Re: dd cdrom error
To: chris@gist.q-station.net (Leung Yau Wai)
Date: Fri, 28 Dec 2001 16:39:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dougg@torque.net (Douglas Gilbert),
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10112282328210.7455-100000@gist.q-station.net> from "Leung Yau Wai" at Dec 28, 2001 11:30:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K02v-00010C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	But, why turning off DMA 'hdparm -d0 /dev/hdd' then everything
> work fine? Do you mean if turning off DMA then 2.4 kernel also knows that
> errors in the last few blocks of an ISO image are not in fact to be
> counted as errors and retried?  Also Jens knows?

No idea. I'd venture the IDE DMA error recovery is broken in the 2.4 tree.
Andre has implied that is the case but since he's having a silly fight with
Linus someone else will have to fix it.

So long as it works in 2.2 I'm not worried. I'm not 2.4 maintainer 8)

Alan
