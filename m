Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132975AbQLIAVo>; Fri, 8 Dec 2000 19:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133087AbQLIAVe>; Fri, 8 Dec 2000 19:21:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25363 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132975AbQLIAV1>; Fri, 8 Dec 2000 19:21:27 -0500
Subject: Re: [PATCH] for YMF PCI sound cards
To: adam@yggdrasil.com (Adam J. Richter)
Date: Fri, 8 Dec 2000 23:51:59 +0000 (GMT)
Cc: proski@gnu.org, kai@thphy.uni-duesseldorf.de, linux-kernel@vger.kernel.org
In-Reply-To: <200012081755.JAA04672@adam.yggdrasil.com> from "Adam J. Richter" at Dec 08, 2000 09:55:29 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144XJ4-0004dy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Loading the module would cause a very loud monotone
> squeal, like some kind of theft detection device.  The computer

Thats actually a generic bug in both ALSA and the kernel AC97 driver
(fixed in 2.2 and by Linus in 2.4test). It is feedback between the microphone
and speakers

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
