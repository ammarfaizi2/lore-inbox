Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269158AbRHYSUJ>; Sat, 25 Aug 2001 14:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269002AbRHYSUA>; Sat, 25 Aug 2001 14:20:00 -0400
Received: from 124-116.dialup.ucalgary.ca ([136.159.124.116]:64772 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S269254AbRHYSTq>;
	Sat, 25 Aug 2001 14:19:46 -0400
Date: Fri, 24 Aug 2001 12:06:35 -0600
From: Andreas Dilger <adilger@turbolabs.com>
To: Erik Tews <erik.tews@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing oops-messages to floppy or disk
Message-ID: <20010824120634.A16615@lynx.no>
Mail-Followup-To: Erik Tews <erik.tews@gmx.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010822164314.B31151@no-maam.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010822164314.B31151@no-maam.dyndns.org>; from erik.tews@gmx.net on Wed, Aug 22, 2001 at 04:43:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 22, 2001  16:43 +0200, Erik Tews wrote:
> So I would like to know if there is a solution to tell the kernel to
> write the current screen (or the oops-message) to floppy (bypassing the
> filesystem, just raw write, reading it back with dd if=/dev/fd0, of=-)

There is a patch that does this (for 2.2, and 2.4 I think) called kmsgdump.
It allows you to dump oops messages to a floppy or to a printer.  It also
has a tool to make a special dump floppy which just lets the boot "pass
through" the floppy and boot from the next BIOS device.  This allows you
to leave the dump floppy in the drive all the time, in case of an oops,
but also allows the system to continue booting afterwards.

I don't know where the current kmsgdump patches are, but Google should
find them.

Cheers, Andreas
-- 
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

