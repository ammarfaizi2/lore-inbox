Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbUCWPZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 10:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUCWPZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 10:25:29 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:21649 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S262599AbUCWPZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 10:25:27 -0500
Date: Tue, 23 Mar 2004 08:25:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: kgdb doesn't respond to Ctrl+C
Message-ID: <20040323152526.GA2330@smtp.west.cox.net>
References: <200403231202.31160.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403231202.31160.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 12:02:30PM +0530, Amit S. Kale wrote:

> I guess something's gone wrong with serial port interrupts.
> 
> Tom, any ideas?

Current CVS works for me.  Relevant .config section:
#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_KGDB=y
CONFIG_KGDB_8250=y
# CONFIG_PPC_SIMPLE_SERIAL is not set
CONFIG_KGDB_SIMPLE_SERIAL=y
CONFIG_KGDB_9600BAUD=y
# CONFIG_KGDB_19200BAUD is not set
# CONFIG_KGDB_38400BAUD is not set
# CONFIG_KGDB_57600BAUD is not set
# CONFIG_KGDB_115200BAUD is not set
CONFIG_KGDB_TTYS0=y
# CONFIG_KGDB_TTYS1 is not set
# CONFIG_KGDB_TTYS2 is not set
# CONFIG_KGDB_TTYS3 is not set
CONFIG_FRAME_POINTER=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

-- 
Tom Rini
http://gate.crashing.org/~trini/
