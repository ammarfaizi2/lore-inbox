Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264245AbRFQCXb>; Sat, 16 Jun 2001 22:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264439AbRFQCXV>; Sat, 16 Jun 2001 22:23:21 -0400
Received: from [207.106.50.26] ([207.106.50.26]:25863 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S264245AbRFQCXK>;
	Sat, 16 Jun 2001 22:23:10 -0400
Date: Sat, 16 Jun 2001 22:27:09 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Cc: rick@linuxmafia.com
Subject: Kernel configuration.  It's not just a job, it's an adventure!
Message-ID: <20010616222709.A11872@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net, rick@linuxmafia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various people on the Linux kernel mailing list and elsewhere have been heard
to opine that CML2's user interface is too oriented towards nontechnical
users.  In response to these complaints, I have implemented a fourth CML2
front end with an interface style expressly designed for the serious,
hard-core hacker.  A transcript of an example session follows:

----------------------------------------------------------------------------
Welcome to CML2 Adventure, version 1.6.1.
You are in a maze of twisty little Linux kernel options menus, all different.
The main room.  A sign reads `Linux Kernel Configuration System'.
Passages lead off in all directions.

> n
The arch room.  A sign reads `Processor type'.
A passage leads upwards.

Choose your processor architecture.
A brass lantern is here.
There is a row of buttons on the wall of this room. They read:
X86, ALPHA, SPARC32, SPARC64, MIPS32, MIPS64, PPC, M68K, ARM, SUPERH, IA64, PARISC, S390, S390X, CRIS
The button marked X86 is pressed.
> take lantern
Lantern: taken.
> look X86
Value of X86 is y.
This is Linux's home port.  Linux was originally native to the Intel
386, and runs on all the later x86 processors including the Intel
486, 586, Pentiums, and various instruction-set-compatible chips by
AMD, Cyrix, and others.
> up
In main room.
> nearby
The arch room.  A sign reads `Processor type'.
The archihacks room.  A sign reads `Architecture-specific hardware hacks'.
The buses room.  A sign reads `System buses and controller types'.
The pm room.  A sign reads `Power management'.
The mtd room.  A sign reads `Memory Technology Device (MTD) support'.
The x86 room.  A sign reads `Intel and compatible 80x86 processor options'.
The policy room.  A sign reads `Configuration policy options'.
The generic room.  A sign reads `Architecture-independent feature selections'.
The block_devices room.  A sign reads `Block devices'.

> go generic
The generic room.  A sign reads `Architecture-independent feature selections'.
A passage leads upwards.

There is an option named MODULES here.
There is an option named NET here.
There is an option named SYSVIPC here.
There is an option named BSD_PROCESS_ACCT here.
There is an option named SYSCTL here.
There is an option named BINFMT_AOUT here.
There is an option named BINFMT_MISC here.
There is an option named SMP here.
> take NET
NET: taken.
> take MODULES
Tristate symbols won't default to M.
MODULES: taken.
> up
In main room.
> nearby
The arch room.  A sign reads `Processor type'.
The archihacks room.  A sign reads `Architecture-specific hardware hacks'.
The buses room.  A sign reads `System buses and controller types'.
The pm room.  A sign reads `Power management'.
The mtd room.  A sign reads `Memory Technology Device (MTD) support'.
The x86 room.  A sign reads `Intel and compatible 80x86 processor options'.
The policy room.  A sign reads `Configuration policy options'.
The generic room.  A sign reads `Architecture-independent feature selections'.
The block_devices room.  A sign reads `Block devices'.

> go buses
The buses room.  A sign reads `System buses and controller types'.
A passage leads upwards.

Specify the buses, disk controllers, and internal interconnection standards
that you want your kernel to support.
It is very dark.  If you continue, you are likely to be eaten by a grue.
There is an option named EISA here.
There is an option named PCI here.
There is an option named PNP here.
There is an option named PARPORT here.
There is an option named HOTPLUG here.
There is an option named IDE here.
There is an option named SCSI here.
There is an option named USB here.
There is an option named I2O here.
There is an option named MTD here.
There is an option named WATCHDOG here.
> light lantern
The lantern radiates a mellow golden light.
> take PCI
PCI: taken.
> help
Welcome to the adventure configurator.  For a command summary, type `commands'.
In general, a three-letter abbreviation of any command word is sufficient
to identify it to the parser.

This interface emulates the style of classic text adventure games such as
Colossal Cave Adventure and Zork.  Configuration menus are rooms, and
configuration options are objects that can be taken and dropped (except
for choice/radiobutton symbols, which become buttons on various room walls).
Objects and rooms may silently appear and disappear as visibilities
change.

Have fun, and beware of the grues!

In main room.
> commands
look [target] -- look here or at target (direction or option).
nearby        -- list nearby rooms (useful with go)
go            -- go to a named menu (follow with the label).
inventory     -- show which options you have picked up.
drop          -- unset option.
take [module] -- set option, follow with option name.
press         -- press a button (follow with the button name).
set           -- set numeric or string; follow with symbol and value.
load          -- read in a configuration (follow with the filename).
save          -- save the configuration (follow with a filename).
xyzzy         -- toggle suppression flag.
quit          -- quit, discarding changes.
exit          -- exit, saving the configuration.
You can move in compass directions n,e,w,s,ne,nw,se,sw or dn for down.
> quit
----------------------------------------------------------------------------
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

What, then is law [government]? It is the collective organization of
the individual right to lawful defense."
	-- Frederic Bastiat, "The Law"


