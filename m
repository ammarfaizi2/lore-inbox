Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311448AbSCNA2s>; Wed, 13 Mar 2002 19:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311458AbSCNA1u>; Wed, 13 Mar 2002 19:27:50 -0500
Received: from ns1.cypress.com ([157.95.67.4]:17882 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id <S311455AbSCNA0g>;
	Wed, 13 Mar 2002 19:26:36 -0500
Message-ID: <3C8FEE2A.8030905@cypress.com>
Date: Wed, 13 Mar 2002 18:26:18 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, 
MIME-Version: 1.0
To: Adam Schrotenboer <adam@tabris.net>
CC: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: [Repost] Tulip Bug ?
In-Reply-To: <20020313203530.8FDABFB911@tabriel.tabris.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner: Scanned but not guaranteed against viruses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adam Schrotenboer wrote:
> (I can't tell if it made its way to the list......)

It made it both times :)

> I also have some more information. This ethdev is connected to a 
> Efficient Networks Speedstream 5260, which may be the cause of the 
> problems (the modem came w/ a D-Link RTL8139C ethdev, but I replaced 
> both of my ethdevs w/ tulips.) Maybe I need to find out how to program 
> the EEPROM for 10Mbps half duplex ?????
> 
> I am currently running 2.4.18-pre9-mjc2, but this also happens w/ 
> 2.4.18-pre9 (and 2.4.18-pre7-mjc, maybe others)

I see it a lot on a Netgear FA310TX
( detected as Lite-On 82c168 PNIC rev 33)
With both v 1.1.8(June 16,2001) and
v 0.9.15-pre9(Nov 6, 2001)
kernel is 2.4.19-pre2-ac2 but it's been a problem for
months.

> I am getting NETDEV Watchdog timeouts

I only get the NETDEV messages.

> I have been getting this at largely unpredictable intervals. The 
> solutions seems to be to ifdown the ethdevs, and rmmod the driver. then 
> ifup the ethdevs (which also means I have to stop my PPPoE-DSL 
> connection).

Using xfs top serve fonts to a Solaris8 box was impossible.
too many timeouts. Same for NFS mounted $HOME (from Solaris)
making it impossible to use the box.

	-Thomas

