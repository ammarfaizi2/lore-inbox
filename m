Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129957AbQLTVO0>; Wed, 20 Dec 2000 16:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbQLTVOQ>; Wed, 20 Dec 2000 16:14:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50697 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129957AbQLTVOE>; Wed, 20 Dec 2000 16:14:04 -0500
Subject: Re: iptables: "stateful inspection?"
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Wed, 20 Dec 2000 20:45:28 +0000 (GMT)
Cc: mhw@wittsend.com (Michael H. Warfield), linux-kernel@vger.kernel.org
In-Reply-To: <3A40DE97.96228B5E@holly-springs.nc.us> from "Michael Rothwell" at Dec 20, 2000 11:30:15 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E148q79-0001y2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Michael H. Warfield" wrote:
> >         I think that's more than a little overstatement on your
> > part.  It depends entirely on the application you intend to put
> > it to.  
> 
> Fine. How do I make FTP work through it? How can I allow all outgoing

Passive mode or a proxy. 

> TCP connections without opening the network to inbound connections on
> the ports of desired services?

It does SYN checking. If you are running 'serious' security you wouldnt be
allowing outgoing connections anyway. One windows christmascard.exe virus that
connects back to an irc server to take input and you are hosed.

So its perfectly adequate for basic security, but if you want serious security
and you don't have passwords on outgoing connections think again. If you are
using ftp then be sure to also use other methods to verify a third party didnt
change the file you up/downloaded too.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
