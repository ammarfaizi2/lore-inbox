Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUC2Ml6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUC2MkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:40:23 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:51364 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262909AbUC2Mig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:38:36 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: kgdb doesn't respond to Ctrl+C
Date: Mon, 29 Mar 2004 17:35:16 +0530
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
References: <200403231202.31160.amitkale@emsyssoft.com> <20040323152526.GA2330@smtp.west.cox.net>
In-Reply-To: <20040323152526.GA2330@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403291735.16412.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works for me too now. Looks like a false alarm

-Amit

On Tuesday 23 Mar 2004 8:55 pm, Tom Rini wrote:
> On Tue, Mar 23, 2004 at 12:02:30PM +0530, Amit S. Kale wrote:
> > I guess something's gone wrong with serial port interrupts.
> >
> > Tom, any ideas?
>
> Current CVS works for me.  Relevant .config section:
> #
> # Kernel hacking
> #
> CONFIG_DEBUG_KERNEL=y
> CONFIG_EARLY_PRINTK=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_DEBUG_SLAB is not set
> # CONFIG_DEBUG_IOVIRT is not set
> CONFIG_MAGIC_SYSRQ=y
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> CONFIG_KGDB=y
> CONFIG_KGDB_8250=y
> # CONFIG_PPC_SIMPLE_SERIAL is not set
> CONFIG_KGDB_SIMPLE_SERIAL=y
> CONFIG_KGDB_9600BAUD=y
> # CONFIG_KGDB_19200BAUD is not set
> # CONFIG_KGDB_38400BAUD is not set
> # CONFIG_KGDB_57600BAUD is not set
> # CONFIG_KGDB_115200BAUD is not set
> CONFIG_KGDB_TTYS0=y
> # CONFIG_KGDB_TTYS1 is not set
> # CONFIG_KGDB_TTYS2 is not set
> # CONFIG_KGDB_TTYS3 is not set
> CONFIG_FRAME_POINTER=y
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_X86_MPPARSE=y

