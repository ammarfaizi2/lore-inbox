Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130843AbQKINm2>; Thu, 9 Nov 2000 08:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130849AbQKINmS>; Thu, 9 Nov 2000 08:42:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37713 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130843AbQKINmK>; Thu, 9 Nov 2000 08:42:10 -0500
Subject: Re: Installing kernel 2.4
To: mwm@i.am (Mark W. McClelland)
Date: Thu, 9 Nov 2000 13:40:38 +0000 (GMT)
Cc: jmerkey@timpanogas.org (Jeff V. Merkey), linux-kernel@vger.kernel.org
In-Reply-To: <3A333D47.6B839036@i.am> from "Mark W. McClelland" at Dec 10, 2000 12:22:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13trwW-0001AR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would like to see some features added to ELF. Resource binding support
> would be nice, i.e. bitmaps used internally by GUI apps and such, so
> that they can be shared between processes if they are in a shared lib,

You can do shared mappings of almost anything anyway. In fact most of the
shared library loading is done in user space via mmap. 

There are good reasons for not putting resources into the program itself too,
one of which is customisability.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
