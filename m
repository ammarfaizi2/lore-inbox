Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRBGMbl>; Wed, 7 Feb 2001 07:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRBGMbb>; Wed, 7 Feb 2001 07:31:31 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:17288 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129282AbRBGMbT>; Wed, 7 Feb 2001 07:31:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] linux 2.4.1 to 2.4.1-ac3 hangs
Date: Wed, 7 Feb 2001 07:30:46 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <01020617572800.00870@oscar>
In-Reply-To: <01020617572800.00870@oscar>
MIME-Version: 1.0
Message-Id: <01020707304600.29374@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In retrospect it looks like there are three problems shown here.

1. The are the packet error messages which have just started appearing in 
ac3, but do not seem to hurt anything...  I am forced to use pppoe and do have
the mtu(s) set correctly (1500 on eth1, 1492 on ppp0 (which runs on eth1), all
internal PC should have 1454 (one was incorrect and is now fixed)).  I am 
using the ipchains module and have not tried the iptables filter to clamp 
mtus.

2. There is a PCI routing error reported during boot.  The kernel does seem 
to resolve this ok - is this message anything to worry about?

3. System hangs.  This box has been quite stable.  The hangs started 
appearing around 2.4.1 or so.  I very much doubt they are heat releated.  I 
have had heat problems in the past an have moved the kit into a much better 
case.  The old symptoms (ide tape problems) have gone and not returned even 
on the hotest summer day...  Next time this happens I will try to telnet or 
ssh into box to see if anything is active, I will also setup a UPS on the box 
and see it that can shut it down.  Its interesting that the software watchdog 
does not get triggered.

TIA,
Ed Tomlinson <tomlins@cam.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
