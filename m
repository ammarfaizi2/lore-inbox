Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261278AbSJLQSy>; Sat, 12 Oct 2002 12:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbSJLQSy>; Sat, 12 Oct 2002 12:18:54 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:47494 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261278AbSJLQSy>;
	Sat, 12 Oct 2002 12:18:54 -0400
Date: Sat, 12 Oct 2002 11:24:37 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Alan Chandler <alan@chandlerfamily.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: How does ide-scsi get loaded?
In-Reply-To: <200210121555.19492.alan@chandlerfamily.org.uk>
Message-ID: <Pine.LNX.4.44.0210121122220.4532-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, Alan Chandler wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Saturday 12 October 2002 3:39 pm, Michael Abshoff wrote:
> > Alan Chandler wrote:
> > >No - its not in there - as I said grep -r of /etc did not show anything
> > >
> 
> >If you are using lilo to boot look for a block like the following: 
>  > image = /boot/vmlinuz 
>  > label = linux 
>  > root = /dev/hda7 
>   >append = "enableapic hdd=ide-scsi" 
> 
> so isn't /etc/lilo.conf in /etc.
> 
> I keep saying - the string ide-scsi is not used anywhere in /etc

Can you send your .config file for the kernel you are running, the dmesg 
output at boot, and your bootloader configuration file (either 
/etc/lilo.conf, or /boot/grub/grub.conf, commonly) for examination?  Maybe 
something will become apparent when the output is examined.

