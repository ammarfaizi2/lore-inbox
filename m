Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284577AbRLETEG>; Wed, 5 Dec 2001 14:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284574AbRLETD5>; Wed, 5 Dec 2001 14:03:57 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16513 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S284593AbRLETDf>; Wed, 5 Dec 2001 14:03:35 -0500
Date: Wed, 5 Dec 2001 14:03:31 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Q A <qarce_mail_lists@yahoo.com>
cc: linux-kernel@vger.kernel.org, qarce@yahoo.com
Subject: Re: ARP shows client is given wrong MAC Address for system with 2 NICs
In-Reply-To: <20011204232549.96879.qmail@web20305.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1011205135505.8200A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[SNIPPED...]
There is an ARP cache, always has been, always will be. This is so
an ARP (Address Resolution Protocol) probe doesn't have to occur for
every data transmission. It is presumed that an IP address, including
your own, won't jump around from device-to-device.

You are moving your IP address to another device (MAC address). What
do you expect?

You can delete the old entries from your ARP cache, but it has to
be done for every system that would be affected or you can just wait
for the ARP cache entry to expire.

    /sbin/arp -d ipaddress


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


