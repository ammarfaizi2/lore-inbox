Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269523AbTCDSRf>; Tue, 4 Mar 2003 13:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269524AbTCDSRf>; Tue, 4 Mar 2003 13:17:35 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:4103 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S269523AbTCDSRe>; Tue, 4 Mar 2003 13:17:34 -0500
Date: Tue, 4 Mar 2003 21:26:48 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: raarts@office.netland.nl
Cc: david.knierim@tekelec.com, alexander@netintact.se,
       Donald Becker <becker@scyld.com>, Greg KH <greg@kroah.com>,
       jamal <hadi@cyberus.ca>, Jeff Garzik <jgarzik@pobox.com>,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PCI init issues
Message-ID: <20030304212648.A6455@jurassic.park.msu.ru>
References: <OFDDD85BEC.1AD47C42-ON85256CDF.0059DE8B@nc.tekelec.com> <3E64E83A.6030705@netland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E64E83A.6030705@netland.nl>; from raarts@netland.nl on Tue, Mar 04, 2003 at 06:54:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 06:54:02PM +0100, Ron Arts wrote:
> It may not be complete, so I also included part of /var/log/messages.

It's complete, thanks.

> IO APIC #4......
...
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
>  00 00F 0F  1    1    0   1   0    1    1    C1
>  01 000 00  1    0    0   0   0    0    0    00
>  02 000 00  1    0    0   0   0    0    0    00
>  03 000 00  1    0    0   0   0    0    0    00
...
> IRQ to pin mappings:
...
> IRQ48 -> 2:0

Indeed, looks like only pin 0 (INT_A of that card) is connected. :-(

Ivan.
