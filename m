Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262589AbREZEZ0>; Sat, 26 May 2001 00:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262593AbREZEZQ>; Sat, 26 May 2001 00:25:16 -0400
Received: from mail.alphalink.com.au ([203.24.205.7]:13632 "EHLO
	mail.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S262589AbREZEZF>; Sat, 26 May 2001 00:25:05 -0400
Message-ID: <3B0F3268.A671BC7A@pocketpenguins.com>
Date: Sat, 26 May 2001 14:34:48 +1000
From: Greg Banks <gbanks@pocketpenguins.com>
Organization: Pocket Penguins Inc
X-Mailer: Mozilla 4.07 [en] (X11; I; Linux 2.2.1 i586)
MIME-Version: 1.0
To: esr@thyrsus.com
CC: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Configure.help entries wanted
In-Reply-To: <20010525012200.A5259@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:
> 
> CONFIG_SH_SCI
> CONFIG_SH_STANDARD_BIOS
> CONFIG_DEBUG_KERNEL_WITH_GDB_STUB

  From the LinuxSH CVS (I can write new ones if these are inadequate):

SuperH SCI (serial) support
CONFIG_SH_SCI
  Selecting this option will allow the Linux kernel to transfer
  data over SCI (Serial Communication Interface) and/or SCIF
  which are built into the Hitachi SuperH processor.

  If in doubt, press "y".

Use LinuxSH standard BIOS
CONFIG_SH_STANDARD_BIOS
  Say Y here if your target has the gdb-sh-stub package from
  www.m17n.org (or any conforming standard LinuxSH BIOS) in FLASH
  or EPROM.  The kernel will use standard BIOS calls during boot
  for various housekeeping tasks.  Note this does not work with
  WindowsCE machines.  If unsure, say N.

GDB Stub kernel debug
CONFIG_DEBUG_KERNEL_WITH_GDB_STUB
  If you say Y here, it will be possible to remotely debug the SuperH
  kernel using gdb, if you have the gdb-sh-stub package from
  www.m17n.org (or any conforming standard LinuxSH BIOS) in FLASH or
  EPROM.  This enlarges your kernel image disk size by several megabytes
  but allows you to load, run and debug the kernel image remotely using
  gdb.  This is only useful for kernel hackers.  If unsure, say N.


Greg.
-- 
These are my opinions not PPIs.
