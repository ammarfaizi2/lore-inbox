Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRBLJz1>; Mon, 12 Feb 2001 04:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130047AbRBLJzB>; Mon, 12 Feb 2001 04:55:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64784 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129382AbRBLJyz>; Mon, 12 Feb 2001 04:54:55 -0500
Subject: Re: WOL failure after shutdown
To: James@nistix.com (James Brents)
Date: Mon, 12 Feb 2001 09:54:41 +0000 (GMT)
Cc: hahn@coffee.psychology.mcmaster.ca (Mark Hahn),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A874C51.5030207@nistix.com> from "James Brents" at Feb 11, 2001 08:37:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SFgy-0006Xb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, I wrote that in a hurry. Its a 3Com PCI 3c905C Tornado. I can 
> successfully use wakeonlan if I power off the machine immeadiatly after 
> turning it on. Using the shutdown command, which it will when I need it 
> to power back up, it will not work.

That would seem reasonable. You probably want the 'poweroff' command to
put the box into completely off state. If you want to just sleep then
apm -s will do an APM suspend.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
