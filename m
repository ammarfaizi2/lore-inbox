Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131515AbQKQMDY>; Fri, 17 Nov 2000 07:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130601AbQKQMDO>; Fri, 17 Nov 2000 07:03:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37724 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129150AbQKQMDB>; Fri, 17 Nov 2000 07:03:01 -0500
Subject: Re: [PATCH] ALS-110 opl3 and mpu401 under 2.4.0-test10
To: mh15@st-andrews.ac.uk (Mark Hindley)
Date: Fri, 17 Nov 2000 11:33:11 +0000 (GMT)
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        tmolina@home.com (Thomas Molina)
In-Reply-To: <l03130300b63ac27dc63a@[138.251.135.28]> from "Mark Hindley" at Nov 17, 2000 11:26:40 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wjlY-0000YD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) The other relates to the uart401 detection. If you build the sb driver
> into the kernel and then pass the commandline uart401=1 this is interpreted
> as the io parameter for the uart401 module not a command for the sb driver.
> I have renamed the uart401 detection command to uart401probe. Obviously it
> isn't a problem with a modular driver, but the change shouldn't matter.

It changes the command line properties people already use. It also cannot be
neccessary since 'uart401' is static.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
