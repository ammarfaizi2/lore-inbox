Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269517AbRHHUtJ>; Wed, 8 Aug 2001 16:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269409AbRHHUs7>; Wed, 8 Aug 2001 16:48:59 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:65056 "EHLO
	mailsorter1.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S269517AbRHHUsr>; Wed, 8 Aug 2001 16:48:47 -0400
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B6FC1@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Mark Hahn'" <hahn@physics.mcmaster.ca>,
        "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.7ac9,10 compile error
Date: Wed, 8 Aug 2001 16:48:51 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying that now.  Looks like that was it.  Jumped the gun on you all
there, in my haste.  Thanks for the quick reply though.

B.

-----Original Message-----
From: Mark Hahn [mailto:hahn@physics.mcmaster.ca]
Sent: Wednesday, August 08, 2001 4:43 PM
To: Holzrichter, Bruce
Subject: Re: 2.4.7ac9,10 compile error


> problems.  Got some errors compiling a sound module to start so I updated
to
> 2.4.7ac9 and tried again, but got the following error.  I also updated to

make oldconfig

> /usr/src/linux-2.4.7/include/linux/irq.h:61: asm/hw_irq.h: No such file or

linux/include/asm is a link to the arch-specific asm tree;
it's created when you configure (oldconfig/xconfig/menuconfig/etc)
