Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSFES4V>; Wed, 5 Jun 2002 14:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSFES4U>; Wed, 5 Jun 2002 14:56:20 -0400
Received: from unicorn.it.wsu.edu ([134.121.1.1]:3344 "EHLO unicorn.it.wsu.edu")
	by vger.kernel.org with ESMTP id <S316088AbSFES4S>;
	Wed, 5 Jun 2002 14:56:18 -0400
Date: Wed, 5 Jun 2002 11:56:08 -0700 (PDT)
From: Eric Kristopher Sandall <sandalle@wsunix.wsu.edu>
To: Michael Zhu <mylinuxk@yahoo.ca>
cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
In-Reply-To: <20020604193806.58478.qmail@web14905.mail.yahoo.com>
Message-ID: <Pine.OSF.4.10.10206051153300.304-100000@unicorn.it.wsu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002, Michael Zhu wrote:

> Hi, I built a kernel module. I can load it into the
> kernle using insmod command. But each time when I
> reboot my computer I couldn't find it any more. I mean
> I need to use the insmod to load the module each time
> I reboot the computer. How can I modify the
> configuration so that the Linux OS can load my module
> automatically during reboot? I need to copy my module
> to the following directory?
>   /lib/modules/2.4.7-10/

You don't need to do this, actually, you should _not_ do this.
 
> I've done that. But it doesn't work.
> 
> Any help will be appreciated.

Just put the module name in /etc/modules
example: I want my network card (3Com 3c905c - 3c59x module), vfat, and
ide-scsi (for my IDE burner) to load at
boot, so I have in my /etc/modules:

3c59x
ide-scsi
vfat

The order does not matter.

-ES

Try out Source Mage GNU/Linux now!  It's magic!  (http://sourcemage.org)

--
Eric Sandall                  |   (P)e-mail: sandalle@mail.wsu.edu
Debian Linux Beowulf Cluster  |      (P)web: http://hellhound.homeip.net/
ICQ: 667348                   | User 196285: http://counter.li.org/
SysAdmin, Shock Physics, WSU  |      (W)web: http://www.shock.wsu.edu/

