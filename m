Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbTIHQqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbTIHQqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:46:33 -0400
Received: from oasis.frogfoot.net ([168.210.54.51]:37061 "HELO
	oasis.frogfoot.net") by vger.kernel.org with SMTP id S262635AbTIHQqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:46:31 -0400
Date: Mon, 8 Sep 2003 18:46:08 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: Fedor Karpelevitch <fedor@karpelevitch.net>
Cc: Linux Kernel Discussions <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: possibly bug in 8139cp? (WAS Re: BUG: 2.4.23-pre3 + ifconfig)
Message-ID: <20030908164608.GA1936@oasis.frogfoot.net>
Mail-Followup-To: Fedor Karpelevitch <fedor@karpelevitch.net>,
	Linux Kernel Discussions <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>
References: <20030904180554.GA21536@oasis.frogfoot.net> <200309071217.03470.fedor@karpelevitch.net> <20030907191552.GA26123@oasis.frogfoot.net> <200309080943.26254.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309080943.26254.fedor@karpelevitch.net>
User-Agent: Mutt/1.3.28i
Organization: Frogfoot Networks CC
X-Operating-System: Debian GNU/Linux oasis 2.4.21 (i686)
X-GPG-Public-Key: http://oasis.frogfoot.net/keys/
X-Uptime: 18:41:20 up 19 days, 23:56, 15 users, load average: 0.00, 0.01, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fedor                                         >@2003.09.08_18:43:25_+0200

Not sure if you've stumbled onto the same bug as me.

My server have 2 Netgear cards and I'm using the National Semiconductor
dp8381x driver included with 2.4.23-pre3.

Also, my system doesn't lock up after `ifconfig lo down', ifconfig just
hangs and becomes unkillable and I can't reboot the machine, use ifconfig
anymore, etc.

> Actually for me this happens when I do "pump -i eth0"
> The system is frozen dead (even SysRq-B does not work)
> That's when I am using 8139cp driver (no problem in 2.4.22)
> I tried using 8139too (I believe it is supposed to work, right?) - I 
> do not get this lockup, but instead it starts printing "too much work 
> at interrupt " messages all the time. It could be connected to the 
> latest changes in 8139 drivers...
> 
> Fedor
> 
> On ?????????????????????? 07 ???????????????? 2003 12:15 pm, Abraham van der Merwe wrote:
> > Hi Fedor                                        
> > >@2003.09.07_21:17:02_+0200
> >
> > > > I just installed 2.4.23-pre3 on one of our servers. If I
> > > > up/down the loopback device multiple times ifconfig hangs on
> > > > the second down (as in unkillable) and afterwards ifconfig
> > > > stops functioning and I can't reboot the machine, etc.
> > > >
> > > > No oopses, kernel panics, messages or anything. The system is
> > > > still alive, it is just as if some system call is hung.
> > > >
> > > > If anyone is interested, I can send my .config or any other
> > > > relevant details.
> > >
> > > I have the same problem. Did you find any solution?
> >
> > No :P Not even sure if anyone on lkml noticed my bug report.
> 

-- 

Regards
 Abraham

Moderation in all things.
		-- Publius Terentius Afer [Terence]

___________________________________________________
 Abraham vd Merwe - Frogfoot Networks CC
 9 Kinnaird Court, 33 Main Street, Newlands, 7700
 Phone: +27 21 686 1665 Cell: +27 82 565 4451
 Http: http://www.frogfoot.net/ Email: abz@frogfoot.net

