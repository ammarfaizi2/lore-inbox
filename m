Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbRE0Bqu>; Sat, 26 May 2001 21:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262695AbRE0Bqk>; Sat, 26 May 2001 21:46:40 -0400
Received: from dhcp64-134-108-221.omih.dca.wayport.net ([64.134.108.221]:23282
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S262694AbRE0Bqb>; Sat, 26 May 2001 21:46:31 -0400
Date: Sat, 26 May 2001 17:48:29 -0400
From: esr@thyrsus.com
To: Greg Banks <gbanks@pocketpenguins.com>
Cc: Jaswinder Singh <jaswinder.singh@3disystems.com>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Configure.help entries wanted
Message-ID: <20010526174829.A1726@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, Greg Banks <gbanks@pocketpenguins.com>,
	Jaswinder Singh <jaswinder.singh@3disystems.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010525012200.A5259@thyrsus.com> <3B0F3268.A671BC7A@pocketpenguins.com> <002401c0e5aa$0049a000$47a6b3d0@Toshiba> <3B0F8042.90DD5C5D@pocketpenguins.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0F8042.90DD5C5D@pocketpenguins.com>; from gbanks@pocketpenguins.com on Sat, May 26, 2001 at 08:06:58PM +1000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Banks <gbanks@pocketpenguins.com>:
>   Having said that, I agree that the help text entries for the SH
> port are in general of less than stellar quality, for various 
> (mostly good) reasons.  I'm hoping ESR will give us some editorial
> feedback which will provide a good excuse to fix them.

Since you asked...

# Choice: superhsys
Generic
CONFIG_SH_GENERIC
  Select Generic if configuring for a generic SuperH system.

  Select SolutionEngine if configuring for a Hitachi SH7709
  or SH7750 evalutation board.

  Select Overdrive if configuring for a ST407750 Overdrive board.
  More information at
  <http://linuxsh.sourceforge.net/docs/7750overdrive.php3>

  Select HP620 if configuring for a HP Jornada HP620.
  More information at
  <http://www.hp.com/jornada>.

  Select HP680 if configuring for a HP Jornada HP680.
  More information at
  <http://www.hp.com/jornada/products/680>.

  Select HP690 if configuring for a HP Jornada HP690.
  More information at <http://www.hp.com/jornada/products/680>.

  Select CqREEK if configuring for a CqREEK SH7708 or SH7750.
  More information at
  <http://sources.redhat.com/ecos/hardware.html#SuperH>.

  Select DMIDA if configuring for a DataMyte 4000 Industrial
  Digital Assistant. More information at <http://www.dmida.com>.

  Select EC3104 if configuring for a system with an Eclipse
  International EC3104 chip, e.g. the Harris AD2000.

  Select Dreamcast if configuring for a SEGA Dreamcast.
  More information at
  <http://www.m17n.org/linux-sh/dreamcast>.

  Select BareCPU if you know what this means, and it applies
  to your system.

Can you be any more explicit about the BareCPU option?

Physical memory start address
CONFIG_MEMORY_START
  The physical memory start address will be automatically
  set to 08000000, unless you selected one of the following
  processor types: SolutionEngine, Overdrive, HP620, HP680, HP690,
  in which case the start address will be set to 0c000000.

  Do not change this address unless you know what you are doing.

Why might someone want to change this address?

Early printk support
CONFIG_SH_EARLY_PRINTK
  Say Y here to redirect kernel printks from the boot console to an
  SCI serial console as soon as one is available.

This was my guess.  Is it correct?

SuperH SCI (serial) support
CONFIG_SH_SCI
  Selecting this option will allow the Linux kernel to transfer
  data over SCI (Serial Communication Interface) and/or SCIF
  which are built into the Hitachi SuperH processor.
  
  If in doubt, press "y".

What data?  Is this just an on-board RS232C controller?

Use LinuxSH standard BIOS
CONFIG_SH_STANDARD_BIOS Say Y here if your target has the gdb-sh-stub
  package from www.m17n.org (or any conforming standard LinuxSH BIOS)
  in FLASH or EPROM.  The kernel will use standard BIOS calls during
  boot for various housekeeping tasks (including calls to read and
  write characters to a system console, get a MAC address from an
  on-board Ethernet interface, and shut down the hardware).  Note this
  does not work with machines with an existing operating system in
  mask ROM and no flash (WindowsCE machines fall in this category).
  If unsure, say N.

Note that I mixed in some information I gathered from reasding the source.
Please check for correctness.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The whole of the Bill [of Rights] is a declaration of the right of the
people at large or considered as individuals...  It establishes some
rights of the individual as unalienable and which consequently, no
majority has a right to deprive them of.
         -- Albert Gallatin, Oct 7 1789
