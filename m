Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLANRW>; Fri, 1 Dec 2000 08:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbQLANRM>; Fri, 1 Dec 2000 08:17:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19017 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129210AbQLANRJ>; Fri, 1 Dec 2000 08:17:09 -0500
Subject: Re: Oops in 2.2.18 with pppd dial in server
To: root@trgras.timpanogas.org (root)
Date: Fri, 1 Dec 2000 12:46:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
In-Reply-To: <20001130185926.A884@trgras.timpanogas.org> from "root" at Nov 30, 2000 06:59:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E141pa0-0000CE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was able to reproduce this oops with a somewhat more reliable ksymoops (I was ready for this nasty bug this time).  Looks like the problem is in the sockets
> code.

The traces so far all match one description , this one included. Its the
'something scribbled a while ago and I just walked the list and found it'

Is your ppp module getting loaded/unloaded a lot. Im wondering if we have
a module related race. That would explain why folks running large ppp dialin
servers simply dont see any problems

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
