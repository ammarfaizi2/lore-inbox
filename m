Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279575AbRJ2WRS>; Mon, 29 Oct 2001 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279576AbRJ2WRI>; Mon, 29 Oct 2001 17:17:08 -0500
Received: from ibis.worldnet.net ([195.3.3.14]:51716 "EHLO ibis.worldnet.net")
	by vger.kernel.org with ESMTP id <S279575AbRJ2WQz>;
	Mon, 29 Oct 2001 17:16:55 -0500
Message-ID: <3BDDD55C.56EDE4E0@worldnet.fr>
Date: Mon, 29 Oct 2001 23:17:00 +0100
From: Laurent Deniel <deniel@worldnet.fr>
Organization: Home
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: willy tarreau <wtarreau@yahoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet NIC dual homing
In-Reply-To: <20011029133921.74466.qmail@web20508.mail.yahoo.com> <3BDDB51C.4095AF84@worldnet.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Deniel wrote:
> 
> Currently only the link status is used to monitor a NIC.
> So it would be nice if an ioctl was available to force a NIC switch-over
> (especially in active-backup policy). This could be used by a user-space
> daemon in case for instance no traffic is detected.
> 
> I see that the bonding driver is included in 2.2.18, what is its status
> in 2.4.x ?
> 
> Regards,
> 
> Laurent

Hmm, it seems that a lot of good stuff (e.g. ARP monitoring and
SIOCBONDCHANGEACTIVE ioctl) are implemented in the bonding patch for 2.4.13.
Will it be included in the mainstream 2.4.x kernel or is it a 2.5 thing ?
