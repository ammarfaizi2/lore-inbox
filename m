Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTA3WkX>; Thu, 30 Jan 2003 17:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbTA3WkX>; Thu, 30 Jan 2003 17:40:23 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:3518
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S267613AbTA3WkW>; Thu, 30 Jan 2003 17:40:22 -0500
Date: Thu, 30 Jan 2003 17:51:38 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wesley Wright <wewright@verizonmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB HardDisk Booting 2.4.20
Message-ID: <20030130175138.A11304@animx.eu.org>
References: <1043947657.7725.32.camel@steven> <1043952432.31674.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <1043952432.31674.22.camel@irongate.swansea.linux.org.uk>; from Alan Cox on Thu, Jan 30, 2003 at 06:47:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My tests show that it seems to work, and I haven't noticed any odd side
> > affects by initcall-ing the usb devices (concern over this topic is why
> > I enabled it for static USB MSD only).
> > 
> > Does this seem a reasonable solution, or does anyone have something more
> > elegant?
> 
> Is there a reason for not using initrd for this. That should let you
> use any kind of root device even ones requiring user space work before
> the real root is mounted.

Yes, I believe there is.  IMO initrd is too much of an annoyance to setup. 
I also have a usb hdd and the only thing I did was read from the keyboard
waiting for an <ENTER> like it does when it waits on the floppy.  Worked
quite well for me and USB Hard disks don't really need user space if
everything's compiled in (from what I've seen).

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
