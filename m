Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287798AbSA0G3q>; Sun, 27 Jan 2002 01:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287865AbSA0G3h>; Sun, 27 Jan 2002 01:29:37 -0500
Received: from crusoe.degler.net ([66.114.64.229]:10246 "EHLO degler.net")
	by vger.kernel.org with ESMTP id <S287798AbSA0G3W>;
	Sun, 27 Jan 2002 01:29:22 -0500
Date: Sun, 27 Jan 2002 01:29:07 -0500
From: Stephen Degler <sdegler@degler.net>
To: Marcel Kunath <kunathma@pilot.msu.edu>
Cc: linux-kernel@vger.kernel.org, rmaynard@nc.rr.com, chingk@ucs.orst.edu,
        draht@suse.de
Subject: Re: ABIT BX6 Rev 2.0 and Kernel Oopses
Message-ID: <20020127012907.C70065@crusoe.degler.net>
In-Reply-To: <200201250932.g0P9Wef21936@pilot18.cl.msu.edu> <200201251243.g0PChCA34512@pilot05.cl.msu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201251243.g0PChCA34512@pilot05.cl.msu.edu>; from kunathma@pilot.msu.edu on Fri, Jan 25, 2002 at 07:43:12AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a thought.  Have you tried clearing the cmos completely by shorting
the jumper on the mb?

skd

On Fri, Jan 25, 2002 at 07:43:12AM -0500, Marcel Kunath wrote:
> I just got mail from Reid and he said he now slowed down his 450 CPu to a
> lower speed and it now boots Linux as well. I guess its a work around but
> there must be a bug to catch either in the kernel or in the BIOS or the
> engineering of the board itsxelf.
> 
> I guess one can only find the bug by getting two original boards and flashing
> the BIOS of one of them and then comparing their functioning.
> 
> mk
> 
> > > Bug Report >
> ---------- > > To: > Linux Kernel Mailing List
> >
> > Cc:
> > Reid rmaynard@nc.rr.com
> > Kenneth chingk@ucs.orst.edu
> > Roman Drahtmüller draht@suse.de
> >
> > I would send a copy of this to ABIT but they aren't very reachable. I don't
> > know a point of contact for the macro-society known as Microsoft.
> >
> >
> >
> > The following is a collection of information and data accumulated after playin
> g
> > with a specific motherboard and a variety of operating systems (for 18 hours).
> 
> > The failure to install, run and operate some of the OS' on the board or rather
> 
> > operate them at the meant to be CPU speed.
> >
> >
> >
> > The report regards:
> >
> >     Abit BX6 Rev. 2   also knows as
> >     Abit BX6 Rev. 2.0 also knows as
> >     Abit BX6-2.0
> >
> >
> > and contains the following sections:
> >
> >     1. GENERAL
> >     2. HARDWARE SETUP
> >     3. PROBLEM SITUATION
> >     4. SUMMARY
> >     5. WEB RESEARCH
> >     6. MY ANALYSIS
> >     7. THANK YOU
> >     8. KERNEL OOPSES
> >     9. LINKS
> >
> >
> >
> > GENERAL
> > -------
> >
> > The board was purchased in December 1999 (built into a machine) and came from
> > the manufacturer with the BIOS 'BXR_MN.BIN'.
> >
> > The latest BIOS is 'BXR_QR.BIN'.
> >
> > The BIOS history can be found here:
> > http://fae.abit.com.tw/eng/download/bios/bx620.htm
> >
> > The machine is filled with a Pentium III CPU 550 MHz. I tested this CPU using
> > the Intel test utility and this CPU is neither overclocked or been tampered
> > with.
> >
> > This board has been specified to work with Linux at:
> >
> > http://lhd.zdnet.com/db/dispproduct.php3?DISP?334
> >
> > Throughout my research I have been in contact with BX6-2.0 users who had no
> > trouble and others who had the same trouble as I did.
> >
> > This board has been known to be used by a variety of overclockers. In my setup
> 
> > no overclocked CPU has been used or in other words my CPU was never intended t
> o
> > be running above its meant to be speed. The target speed of the Pentium III 55
> 0
> > MHz was always 550MHz.
> >
> >
> > During my testing I have removed all unnecessary hardware from the setup tryin
> g
> > to find a hardware component that caused the problems. I could not however.
> >
> >
> > HARDWARE SETUP
> > --------------
> >
> > Abit BX6-2.0 (SLOT 1 mobo)
> > Pentium III 550 Mhz
> > Kingston Valueram 256 MB PC100
> > LG CD-RW CED-8042B
> > NVIDIA RIVA TNT2 32 MB AGP
> > IBM 30.7 GB 75GXP DTLA-307030 (brand new so its got nothing to do with the
> > drive; I know this drive has been having its own bad calls in the news but it
> > is not the issue here)
> > Lite-ON Monitor
> >
> > Over the course of my testing I also tried another stick of memory, a Trident
> > 3Dimage 4MB AGP card and a Toshiba 24x CD-Rom. The same problem I am about to
> > discuss occurred.
> >
> >
> > PROBLEM SITUATION
> > -----------------
> >
> > After the purchase in 1999 I installed SuSE 6.2 on the machine. I don't
> > remember having any trouble at it and I am pretty sure it was at the CPU speed
> 
> > of 550MHz. The machine came with Win98 and has been running for 2 years with
> > Win98. The SuSE install was only a test run back then and I had wiped it off
> > the disk afterwards.
> >
> > 2002: My latest goal was installing Windows XP on this new drive in the
> > machine. (The drive before was a DTLA-305030). I had updated the BIOS two
> > months ago to QR and Win98 ran fine.
> >
> > For the next few paragraphs the CPU is running at 550MHz!!!
> >
> > I put in the XP CD and it booted and I formatted a 6 Gig partition in NTFS. In
> 
> > the install procedure it copies over a bunch of files and then reboots to then
> 
> > drive the rest of the installation from harddisk. On this reboot I got a Blue
> > Screen Of Death. It reported that there was a Stop error when a process tried
> > to write to read-only memory. I therefore removed all hardware and turned of
> > caching and shadowing in the BIOS to diagnose the problem. The problem
> > persisted and I get either BSOD's or stalls. The BSOD's report
> > (DRIVER_)IRQL_NOT_LESS_OR_EQUAL errors now. Microsoft support pages give the
> > same advice I already applied but the OS won't load.
> >
> > I then went back and installed Win98 to check for sure something wasn't out of
> 
> > order. It installed without hitch and booted and ran fine.
> >
> > I went back to installing XP with the same problem occuring.
> >
> > I went back to older BIOS. I tried MN, KU, HJ. It didn't help.
> >
> > I pulled out a set of Mandrake 8.1 CDs and it booted off CD but then stalled o
> r
> > crashed. I pulled out a old set of SuSE 6.4 CDs and it booted but as soon as
> > the kernel loaded it oopsed.
> >
> > All while doing this I was searching the web for help and gathered tips from a
> 
> > couple of mailing lists.
> >
> > Accidentally I set the CPU to a lower speed than 550MHz and booted the machine
> .
> > The BIOS complained that the CPU was misconfigured and I should change the BIO
> S
> > settings but it also gave me the option to go ahead (F1) and boot anyhow.
> >
> > The CPU is at 366 MHz (underclocked)!!!!!
> >
> > I went ahead and suddenly XP booted.
> >
> > Here I went and pulled out my SuSE 6.4 CD and now it wouldn't oops anymore. I
> > went ahead and installed SuSE 6.4 on a second partition. I rebooted and it
> > booted just fine.
> >
> > I went back and set the CPU back to 550Mhz and booting XP or SuSE became
> > impossible again. SuSE kernel dumped a large oops onto my screen.
> >
> > Today I got a set of RedHat 7.2 CDs and it will not install at 550MHz. It
> > stalls or suddenly reboots. I set the CPU to 366 MHz again and installed RH
> > onto another partition. My setup is now:
> >
> > /dev/hda1 XP
> > /dev/hda2 SuSE 6.4
> > /dev/hda3 swap
> > /dev/hda4 RH 7.2
> >
> > After having installed RH I rebooted and it boots fine at 366 MHz. If I set th
> e
> > CPU to 550Mhz the RH kernel oopses.
> >
> >
> > Now many people suggested to turn off about everything in the BIOS and work my
> 
> > way upwards. I did this and only left IDE controller enabled. It booted fine a
> t
> > 366 Mhz. As soon as I switched to 550 Mhz even with L2 Cache and L1 Cache
> > disabled and any shadowing turned off too it would stall.
> >
> >
> > SUMMARY
> > -------
> >
> > Original motherboard allowed for Linux installation (SuSE 6.2) and runs Win98
> > fine at speed 550MHz Pentium III CPU. No problems for two years and to this
> > date with Win98.
> >
> > The BIOS was updated in late 2001 to QR. The machine still runs Win98 fine at
> > 550MHz. Operating systems such as XP, RH, SuSE must be installed and run at 36
> 6
> > MHz now. UNDERCLOCKED!!!
> >
> >
> > WEB RESEARCH
> > ------------
> >
> > I have dug into google and found quite some information. This problem has been
> 
> > known but occurs very rarely and in only special cases and I think I know why.
> 
> >
> > If I ran XP at 550 Mhz and chose Safe Mode it would run down a list of modules
> 
> > loaded and suddenly stall at "driver/agp440.sys".
> >
> > I searched google and a ton of people using 2K or XP have trouble with the
> > agp440.sys problem. This doesn't mean AGP is the cause here since XP doesn't
> > dump out its real module loading log when loading. agp440.sys is just the last
> 
> > module mentioned before it stalls.
> >
> > The agp440.sys problem occurs also for many other boards and configurations
> > (e.g. Athlon, P4 and other NVIDIA cards)
> >
> > I figured this was not the right direction.
> >
> > Having remembered that I once ran Linux on this board two years ago I figured
> > its either the CPU or the mobo. I remembered I flashed the BIOS recently. I
> > looked up what I could find and voila people did the same as me and had the
> > same trouble:
> >
> > Reid reports that all his mobo can run is Win98 and neither 2K, Linux or BSDs
> > runs:
> >
> > http://groups.google.com/groups?hl=en&frame=right&th=b5b6671ee8e4a3ad&seekm=q2
> vZ
> > 6.77281%24ru2.22650002%40typhoon.southeast.rr.com#link1
> >
> > A reverting to the old BIOS does not help. I contacted Reid and he still has n
> o
> > fix for the situation.
> >
> > I got another example which is exactly like mine and Reid's:
> >
> > http://groups.google.com/groups?q=bx6+kernel+panic&hl=en&selm=37B6EE47.3D9A3AE
> 5%
> > 40ucs.orst.edu&rnum=3
> >
> > Kenneth ran NT on his BX6-2. It worked wonderfully. Then he flashed his BIOS
> > and it oopsed from thereon in. He went back to use his old BIOS but his OS is
> > still unstable. He tried Mandrake on it then and it won't succeed but oopses.
> >
> >
> > MY ANALYSIS
> > -----------
> >
> > The board as it was manufactured was able to run all types of OS. Manypeople
> > have assured me that is what they are doing.
> >
> > I and Reid though cannot run anything but Win9x. The thing that makes our case
> 
> > special is that we both flashed the BIOS and then tried to install XP or Linux
> .
> >
> >
> > I do wonder if the BIOS installed at the plant was in some way special and any
> 
> > BIOS flashed at home and downloaded from the web are containing inconsistencie
> s
> > which break the mobo from working with NT or Linux kernels. The fact that
> > others run Linux and Nt fine on their mobo but my flashed and revertedly
> > flashed mobo cannot makes me wonder.
> >
> >
> > THANK YOU
> > ---------
> >
> > I would love to contact Abit about this but they don't leave a single point of
> 
> > contact on their web pages.
> >
> > I appreciate any comments in regards to this issue. I will now report what the
> 
> > kernel errored on and it may help the hackers in building an opinion about thi
> s
> > issue.
> >
> > Thank you for reading this lengthy document! I could care less if Ican run a
> > certain OS on this specific by today's standard's outdatedbox but it bugs me
> > that there seems to have creaped in a bug intoABIT's board which makes it
> > incompatible with a advanced kernel like the Linux 2.2 or 2.4 kernel and the N
> T
> > kernel as well but gives it theability to handle the functionality of the Win9
> x
> > kernel.
> >
> > I wish somebody would invest the time in researching this topic in detail.
> >
> > I know ABIT has their own Linux distro. I do not have a copy of it but I would
> 
> > be damn curious to know if their distro runs on their ownboard after a BIOS
> > flash.
> >
> > Thanks for your time and if you need more info contact me,
> >
> > Marcel
> >
> >
> > KERNEL OOPSES
> > -------------
> >
> > RH 7.2 default i686 kernel (I think its 2.4.7):
> >
> > EXT3-fs: mounted filesystem with ordered data mode.
> > Freeing unused kernel memory: 220k freed.
> > CPU 0: Machine Check Exception: 0000000000000004
> > Bank 3: b20000000002010a
> > Kernel panic: CPU context corrupt
> > In interrupt handler - not syncing
> >
> >
> > SuSE 6.4 default 2.2.14 kernel:
> >
> > Unable to handle kernel paging request at virtual address 05efa769.2%
> > current->tss.cr3 = 00101000, %cr3 = 00101000
> > *pde = 00000000
> > Oops: 0002
> > CPU: 0
> > EIP: 0010:[<c011825>]
> > EFLAGS: 00010013
> > eax: 000000ff ebx: c0289f24 ecx: 00008c7e edx: c0289f24
> > esi: 20000001 edi: 00000000 ebp: c0289e6c esp: c0289e74
> > ds: 0018 es: 0018 ss: 0018
> > Process swapper (pid: 0, process nr: 0, stackpage=c0289000)
> > Stack: c0289f24 24000001 0000000e c0289f24 c026ad58 00000001 c0289eacc01d43b4
> >        00000001 00000695............
> > Call Trace: ........................
> > Code: 28 8b 45 08 c7 45 f4 00 00 00 00 c7 45 f0 00 00 00 00 89 45
> > Aiee, killing interrupt handler
> > Kernel panic: Attempted to kill idle task!
> > In swapper task - not syncing.
> >
> >
> >
> >
> > Kenneth's Mandrake 6.0 Oops:
> >
> > Kernel panic: LRU block list corrupted
> > Unable to handle kernul NULL pointer dereference at virtual address
> > 00000028
> > current->tss.cr3 = 00101000, %cr3 = 00101000
> > *pde = 00000000
> > Oops: 0000
> > CPU: 0
> > .
> > .
> > .
> >
> >
> > LINKS
> > -----
> >
> > Abit Support:
> > http://fae.abit.com.tw/eng/
> >
> > Abit BX6 Rev. 2:
> > http://fae.abit.com.tw/eng/download/bios/bx620.htm
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
