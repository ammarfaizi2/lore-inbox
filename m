Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279420AbRJ2T7j>; Mon, 29 Oct 2001 14:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279421AbRJ2T7a>; Mon, 29 Oct 2001 14:59:30 -0500
Received: from ibis.worldnet.net ([195.3.3.14]:43275 "EHLO ibis.worldnet.net")
	by vger.kernel.org with ESMTP id <S279420AbRJ2T7R>;
	Mon, 29 Oct 2001 14:59:17 -0500
Message-ID: <3BDDB51C.4095AF84@worldnet.fr>
Date: Mon, 29 Oct 2001 20:59:24 +0100
From: Laurent Deniel <deniel@worldnet.fr>
Organization: Home
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, fr
MIME-Version: 1.0
To: willy tarreau <wtarreau@yahoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet NIC dual homing
In-Reply-To: <20011029133921.74466.qmail@web20508.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

willy tarreau wrote:
> 
> Hi Laurent,
> 
> > Does someone know if there is some work in the area of NIC
> > dual homing ?
> 
> I have implemented this for 2.2 kernel a while ago,
> and Chad Tindel has completed the port to 2.4. Some other
> contributors have added features such as XOR distribution. You can
> take a look at it, kernel 2.4 patches are on :
> 
>    http://sf.net/projects/bonding/
> 
> and 2.2 patches are on :
>
> http://www-miaif.lip6.fr/willy/linux-patches/bonding/
>

Thanks for the pointers.

Currently only the link status is used to monitor a NIC.
So it would be nice if an ioctl was available to force a NIC switch-over
(especially in active-backup policy). This could be used by a user-space
daemon in case for instance no traffic is detected.

I see that the bonding driver is included in 2.2.18, what is its status
in 2.4.x ?

Regards,

Laurent
