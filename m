Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268217AbRHYSTa>; Sat, 25 Aug 2001 14:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269254AbRHYSTT>; Sat, 25 Aug 2001 14:19:19 -0400
Received: from 124-116.dialup.ucalgary.ca ([136.159.124.116]:62724 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S268217AbRHYSS7>;
	Sat, 25 Aug 2001 14:18:59 -0400
Date: Sat, 25 Aug 2001 12:09:35 -0600
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Ebling <kernelhacker@lineone.net>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: suggestions for new kernel hacking-HOWTO
Message-ID: <20010825120935.H16615@lynx.no>
Mail-Followup-To: Andrew Ebling <kernelhacker@lineone.net>,
	kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <998602169.405.21.camel@elixr.jfreak>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <998602169.405.21.camel@elixr.jfreak>; from kernelhacker@lineone.net on Thu, Aug 23, 2001 at 10:29:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 23, 2001  22:29 +0100, Andrew Ebling wrote:
> - How do I... ?
>         - Print messages to kernel logs
>         - create a new module
>         - Add a system call
>         - write ioctls
>         - Add a /proc entry
>         - Write a driver for a new device
>         - Add an option to the kernel configuation

Be sure to add notes about why NOT to add new system calls, ioctls, /proc
entries, etc.  It seems that the popular way to communicate to the kernel
these days is to be able to read/write data to the kernel device driver
via opening a device, or exporting a pseudo filesystem with information.

> I'm interested in hearing from seasoned kernel hackers (on what
> should/shouldn't go in this HOWTO) and newbies (what is particularly
> puzzling or not clear when setting out), hence the cross posting of this
> message.

Check out kernelnewbies.org as well, no point in re-inventing the wheel.

Cheers, Andreas
-- 
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

