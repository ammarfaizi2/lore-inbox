Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129863AbQLJJlV>; Sun, 10 Dec 2000 04:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129960AbQLJJlL>; Sun, 10 Dec 2000 04:41:11 -0500
Received: from smarty.smart.net ([207.176.80.102]:38154 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S129863AbQLJJk7>;
	Sun, 10 Dec 2000 04:40:59 -0500
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200012100910.EAA28516@smarty.smart.net>
Subject: unusual x86 bootsector
To: linux-kernel@vger.kernel.org
Date: Sun, 10 Dec 100 04:10:29 -0500 (EST)
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftp://linux01.gwdg.de/pub/cLIeNUX/interim/Janet_Reno.tgz

pmode bootsector handles pmode x86 int calls as real mode 
AT BIOS calls. I think it might even be reentrant. It worked
on a clone but not on a PS/2 with int $0x10 $0x0e ...
glass teletype output character. The DDD is the BIOS
called from pmode, the other screen noise is straight pmode.

Rick Hohensee
humbuba@smart.net
Forth, unix, cLIeNUX


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
