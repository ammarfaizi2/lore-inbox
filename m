Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130668AbRCEVBN>; Mon, 5 Mar 2001 16:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbRCEVAy>; Mon, 5 Mar 2001 16:00:54 -0500
Received: from fenrus.demon.co.uk ([158.152.228.152]:15745 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S130663AbRCEVAv>;
	Mon, 5 Mar 2001 16:00:51 -0500
Message-Id: <m14a253-000OatC@amadeus.home.nl>
Date: Mon, 5 Mar 2001 20:59:45 +0000 (GMT)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: pavel@suse.cz (Pavel Machek)
Subject: Re: 2.4.2 broke in-kernel ide_cs support
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <20010305091313.A138@bug.ucw.cz>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010305091313.A138@bug.ucw.cz> you wrote:
> Hi!

> I do not yet know details, but it worked in 2.4.1 and it does not work
> now:

> Mar  5 09:12:05 bug cardmgr[69]: initializing socket 1
> Mar  5 09:12:05 bug cardmgr[69]: socket 1: ATA/IDE Fixed Disk
> Mar  5 09:12:05 bug cardmgr[69]: module //pcmcia/ide_cs.o not
> available

That is correct. 
the module is called ide-cs.o and has been for a long time.....
You must have lost your symlink :)

It's better to change the /etc/pcmcia files to use ide-cs though, as that
actually has a chance of working. (and works for me very well)

Greetings,
   Arjan van de Ven
