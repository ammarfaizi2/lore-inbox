Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285146AbRLFOXj>; Thu, 6 Dec 2001 09:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285147AbRLFOXU>; Thu, 6 Dec 2001 09:23:20 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:36620 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285146AbRLFOXL>;
	Thu, 6 Dec 2001 09:23:11 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Missing Configure,help entries need filling in 
In-Reply-To: Your message of "Sat, 01 Dec 2001 12:26:08 CDT."
             <20011201122608.A9983@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Dec 2001 01:22:59 +1100
Message-ID: <16397.1007648579@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001 12:26:08 -0500, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>We're down to 120 missing help entries.  If you can fill some of these
>in, please send me a patch for Configure.help.

CONFIG_DEBUG_RWLOCK
Read-write spinlock debugging
  If you say Y here then read-write lock processing will count how many
  times it has tried to get the lock and issue an error message after
  too many attempts.  If you suspect a rwlock problem or a kernel
  hacker asks for this option then say Y.  Otherwise say N.

CONFIG_DEBUG_SEMAPHORE
Semaphore debugging
  If you say Y here then semaphore processing will issue lots of
  verbose debugging messages.  If you suspect a semaphore problem or a
  kernel hacker asks for this option then say Y.  Otherwise say N.

AU1000 serial console
AU1000_SERIAL_CONSOLE
  If you have an Alchemy AU1000 processor (MIPS based) and you want
  to use a console on a serial port, say Y.  Otherwise, say N.

AU1000 serial support
AU1000_UART
  If you have an Alchemy AU1000 processor (MIPS based) and you want
  to use serial ports, say Y.  Otherwise, say N.

AU1000 ethernet controller on SGI MIPS system
MIPS_AU1000_ENET
  If you have an Alchemy Semi AU1000 ethernet controller
  on an SGI MIPS system, say Y.  Otherwise, say N.

WD93 SCSI Controller on SGI MIPS system
SGIWD93_SCSI
  If you have a Western Digital WD93 SCSI controller on
  an SGI MIPS system, say Y.  Otherwise, say N.

IA64_GRANULE_16MB
Physical memory granularity (16 MB)
  IA64 identity-mapped regions use a large page size.  We'll call such
  large pages "granules".  If you can think of a better name that's
  unambiguous, let us know...  Unless your identity-mapped regions are
  very large, select a granule size of 16MB.

IA64_GRANULE_64MB
Physical memory granularity (64 MB)
  IA64 identity-mapped regions use a large page size.  We'll call such
  large pages "granules".  If you can think of a better name that's
  unambiguous, let us know...  Unless your identity-mapped regions are
  very large, select a granule size of 16MB.

IA64_SGI_SN_DEBUG
Enable SGI SN extra debugging code
  Turns on extra debugging code in the SGI SN (Scalable NUMA) platform
  for IA64.  Unless you are debugging problems on an SGI SN IA64 box,
  say N.

IA64_SGI_SN_SIM
Enable SGI Medusa Simulator Support
  If you are compiling a kernel that will run under SGI's IA64
  simulator (Medusa) then say Y, otherwise say N.

CONFIG_PCIBA
PCIBA Support
  IRIX PCIBA-inspired user mode PCI interface for the SGI SN (Scalable
  NUMA) platform for IA64.  Unless you are compiling a kernel for an
  SGI SN IA64 box, say N.

SERIAL_SGI_L1_PROTOCOL
Enable protocol mode for the L1 console
  Uses protocol mode instead of raw mode for the level 1 console on the
  SGI SN (Scalable NUMA) platform for IA64.  If you are compiling for
  an SGI SN box then Y is the recommended value, otherwise say N.


