Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129781AbQLUBTR>; Wed, 20 Dec 2000 20:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130462AbQLUBTH>; Wed, 20 Dec 2000 20:19:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47115 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130439AbQLUBS4>; Wed, 20 Dec 2000 20:18:56 -0500
Subject: Re: Extreme IDE slowdown with 2.2.18
To: ja@ssi.bg (Julian Anastasov)
Date: Thu, 21 Dec 2000 00:49:45 +0000 (GMT)
Cc: robho956@student.liu.se (Robert Högberg),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.21.0012202246510.6151-100000@u> from "Julian Anastasov" at Dec 20, 2000 11:00:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E148tvX-0002Jp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > known problem with the 2.2.18 kernel?
> 
> 	Yes, 2.2.18 is not friendly to all MVP3 users. The autodma
> detection was disabled for the all *VP3 users in drivers/block/ide-pci.=
> c.

Because it was causing disk corruption for some people. It took a lot of 
tracking down and I want the shipped kernel safe. I now know I'm covering too
many chip versions so 2.2.19 I can get the later VP3's back okay


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
