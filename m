Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129787AbQKINkJ>; Thu, 9 Nov 2000 08:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130738AbQKINkB>; Thu, 9 Nov 2000 08:40:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1617 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129809AbQKINjp>; Thu, 9 Nov 2000 08:39:45 -0500
Subject: Re: [PATCH] media/radio [check_region() removal... ]
To: pazke@orbita.don.sitek.net (Andrey Panin)
Date: Thu, 9 Nov 2000 13:37:41 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <20001109160652.A1953@debian> from "Andrey Panin" at Nov 09, 2000 04:06:52 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13trtf-0001A3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2) i found that some net drivers (3c527.c, sk_mca.c) use io region and
> don't call request_region() at all. Should they be fixed ?

Probably.

MCA bus ensures there can be no collisions of I/O space but it does mean the
user cannot see what is where as is

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
