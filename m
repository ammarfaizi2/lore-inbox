Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318231AbSHNNgt>; Wed, 14 Aug 2002 09:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318301AbSHNNgt>; Wed, 14 Aug 2002 09:36:49 -0400
Received: from richardson.uni2.net ([130.227.52.104]:9361 "EHLO
	richardson.uni2.net") by vger.kernel.org with ESMTP
	id <S318231AbSHNNgs>; Wed, 14 Aug 2002 09:36:48 -0400
Message-ID: <D0B43857843DD41185DE0060979AC20C2FD38F@intermail.pallas.dk>
From: Agust Karlsson <Gusti@pallas.dk>
To: "'David Woodhouse'" <dwmw2@infradead.org>,
       Agust Karlsson <Gusti@pallas.dk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Semaphore block in fs/super.c mount_root 
Date: Wed, 14 Aug 2002 15:40:31 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.
Yes I saw that solution (after I had traced the semaphore :-) ), but as far
I can see the problem is the missing up_read() not the mtd driver.

Gusti

> -----Original Message-----
> From:	David Woodhouse [SMTP:dwmw2@infradead.org]
> Sent:	Wednesday, August 14, 2002 3:33 PM
> To:	Agust Karlsson
> Cc:	'linux-kernel@vger.kernel.org'
> Subject:	Re: Semaphore block in fs/super.c mount_root 
> 
> 
> Gusti@pallas.dk said:
> > I have been trying to get a jffs2 file system to mount as root with
> > kernel 2.4.18.
> 
> http://lists.infradead.org/pipermail/linux-mtd/2002-March/004488.html
> http://lists.infradead.org/pipermail/linux-mtd/2002-March/004489.html
> 
> --
> dwmw2
> 
