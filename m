Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261564AbREUQTP>; Mon, 21 May 2001 12:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbREUQTF>; Mon, 21 May 2001 12:19:05 -0400
Received: from node17.benchmk.com ([207.180.73.117]:40196 "EHLO noop.")
	by vger.kernel.org with ESMTP id <S261564AbREUQSt>;
	Mon, 21 May 2001 12:18:49 -0400
To: linux-kernel@vger.kernel.org
Subject: ACPI - console problems 2.4.4
From: Nick Papadonis <npapadon@yahoo.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: 21 May 2001 12:17:55 -0400
Message-ID: <m3ae46fzgs.fsf@yahoo.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone having problems with ACPI causing console problems in kernel
2.4.4 w/ Intel's patches?   When watching my system boot over the
serial console, things work fine.  When looking at my VAIO-FX140's
LCD, my console no longer updates after ACPI starts initializing _INI methods.

I am able to login and shutdown without my LCD echoing back.

Here is my output from the serial port:

--------------------------------------------------------------------------------


tbxface-0089: 
**** Context Switch from TID FFFFFFFF to TID 1 ****
ACPI Tables successfully loaded
Parsing Methods:...................................................................................................................................................................................................

195 Control Methods found and parsed (554 nodes total)
ACPI Namespace successfully loaded at root c034a2d8
ACPI: Core Subsystem version [20010427]
evxfevnt-0082: Transition to ACPI mode successful
Executing device _INI methods:..............


******************* LAPTOP CONSOLE NO LONGER DISPLAYS ANYTHING ********************


evregion-0304: Ev_address_space_dispatch: Region handler: AE_ERROR [PCIConfig]
breakpoint: Fatal error encountered
  nsinit-0333: \   /_SB_PCI0HUB_CRD1._INI failed: AE_ERROR
........................................
54 Devices found: 54 _STA, 1 _INI
Completing Region and Field initialization:.................
12/18 Regions, 5/5 Fields initialized (554 nodes total)
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S3 S4 S5
Processor[0]: C0 C1 C2, throttling states: 8
Battery: socket found, battery present
Battery: socket found, battery absent
AC Adapter: found
Power Button: found
Lid Switch: found
Thermal Zone: found
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
DEBUG: mount root filesystem
VFS: Mounted root (ext2 filesystem) readonly.
DEBUG: mounted root file
DEBUG: free_initmem()
Freeing unused kernel memory: 196k freed
DEBUG: unlock kernel()
DEBUG: open /dev/console
DEBUG: exec init somewhere

Restarting system.

-- 
Nick
PGP KEY: http://www.coelacanth.com/~nick/npapadon.public.asc
