Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQLLMzb>; Tue, 12 Dec 2000 07:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbQLLMzV>; Tue, 12 Dec 2000 07:55:21 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:261 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129669AbQLLMzJ>; Tue, 12 Dec 2000 07:55:09 -0500
Subject: Re: Linux 2.2.18 release notes
To: peter@cadcamlab.org (Peter Samuelson)
Date: Tue, 12 Dec 2000 12:26:26 +0000 (GMT)
Cc: paulkf@microgate.com (Paul Fulghum), linux-kernel@vger.kernel.org
In-Reply-To: <20001211214757.C3199@cadcamlab.org> from "Peter Samuelson" at Dec 11, 2000 09:47:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145oVp-00017a-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And thus it follows that 2.2.18 is the least buggy kernel ever, since
> it has gotten the most bug fixes.
> 
> Right? (:

Hopefully not.

Remove

	arch/m68k
	arch/arm
	include/asm-m68k
	include/asm-arm
	drivers/usb
	drivers/char/agp
	drivers/char/drm
	..

and count the actual changes to existing code

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
