Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311269AbSDDH3V>; Thu, 4 Apr 2002 02:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311270AbSDDH3M>; Thu, 4 Apr 2002 02:29:12 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:19427 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S311269AbSDDH3E> convert rfc822-to-8bit; Thu, 4 Apr 2002 02:29:04 -0500
Message-Id: <200204032254.g33MsudC028678@codeman.linux-systeme.org>
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <mcp@linux-systeme.de>
Reply-To: mcp@linux-systeme.de
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Kernel 2.4.18-WOLK3.2
Date: Thu, 4 Apr 2002 08:28:35 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
X-PRIORITY: 2 (High)
Content-Transfer-Encoding: 7BIT
X-MIME-Autoconverted: from quoted-printable to 8bit by codeman.linux-systeme.org id g33MsudC028678
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel - patched - WOLK3.2 - Base: Linux kernel 2.4.18

by Marc-Christian Petersen <mcp@linux-systeme.de>


WOLK 3.2 contains several bugfixes found in WOLK 3.1 reported by
users of wolk and found by myself and some new adds/updates which
can be found in the changelog.

Thanks to darix <darix@irssi.de> for the project name WOLK :-)


What is this? Why another patchset/patched kernel?

Using Linux since years, very tired of there are not really good
patchsets available. Saw FOLK Patch/Kernel which is still very very buggy.

Inspired by the jp-Patchsets from Joerg Prante <joerg@infolinux.de>.


The WOLK's are development kernels/patchsets for testing purpose only.
!! If you want to use it in production, use it at your own risk !!
Their purpose is to provide a service for developers and end-users who
can't be up to date with the latest official stable kernels/patches but
want to test many features out there linux can use. Maybe, (hopefully)
some of them will be included into the mainstream kernel 2.4 soon.

There will always be a new WOLK major release if there is a new final
kernel released. Minor releases only if someone/me found critical bugs,
or in case of some adds.

You are missing a patch? Patches will be added by request.
You think one or more of the patches are fully useless? Tell me why.
You have minor, major or heavy mega problems, let me know. I will try to fix.
You think this is great? Let me know too :-)
You've found a bug? Report it!!

You want YOUR patch to be included in WOLK? Let me know :)
Please send your merge against this release to me in that case.

You want to join this project as a developer? Let me know too!
I need help in successfully applying rmap and O(1) scheduler with all
the other patches in this set !
   
There is also a mailinglist available you can join at:
https://sourceforge.net/mail/?group_id=49048


Some of the features:
---------------------
grsecurity, crypto, win4lin, xfs, kdb, jfs, kdb, preempt, freeswan(ipsec),
IPVS, i2c/lmsensors, tux, uml, ltt, compressed cache, evms, badmem, ABI,
software suspend, supermount ... and many more.


Overview:
---------
For a complete overview go to http://sf.net/projects/wolk
The full list of patches is http://prdownloads.sf.net/wolk/WOLK-OVERVIEW
The WOLK 3.2 kernel/patchset contains now over 100 Patches.

Credits go to all the people who created the patches, working hard on
improving the quality.


Changes in WOLK 3.2
-------------------
o   add:        ppSCSI Driver (ParallelPort SCSI) + ParPort Fixes
                (request by Eduard Bloch <blade@debian.org>)

o   add:        Software Suspend + ACPI Fixes
                (request by Pavel Machek <pavel@ucw.cz>)

o   add:        MPPE
                (request by Moritz Muehlenhoff< jmm@Informatik.Uni-Bremen.DE>)

o   add:        printk messages suppress
                (request by Waldemar Brotkorb <waldemar@thinknow.de>)

o   add:        64bit jiffies (Displaying uptime > 497 days)

o   add:        dpath() patch

o   add:        SuperMount

o   add:        CDfs v0.5b

o   add:        Linux-ABI

o   add:        Enterprise Volume Management System (EVMS) v1.0

o   add:        BeFS Filesystem Driver (BeOS FS) v0.92

o   add:        Preempt Stats

o   update:     IPVS v1.02

o   update:     JFS v1.0.17

o   update:     Preempt Kernel (2.4.18-4)

o   update:     ACPI (March 29th, 2002)
                
o   update:     real zlib patch

o   update:     UML (UserModeLinux -13)

o   change:     There was a compile error with KDB on. Fixed!

o   change:     version-prefix is now lowercased cause it
                breaks debian's make-kpkg (their policy)
    
o   change:     Configure.help Updates about feature HTB and Win4Lin

o   change:     LTT (Trace Toolkit) now only shows up
                if SMP is disabled, cause its not SMP capable.
                Also there were compile errors if SMP and LTT was on.

o   change:     Compressed Cache now only shows up
                if SMP is disabled, cause it has no SMP support.

o   change:     Win4Lin now only shows up if Module support
                is enabled, cause it only compiles as a module

o   change:     renumbered the Patches, cause i ran into troubles
                as i've breaked the 99th patch :)

o   Very minor fixes found in WOLK 3.1


--------------------------------------------------------------------------
Feel free to send me feedback. Please CC, I am not subscribed to the lkml.
--------------------------------------------------------------------------


The next major WOLK (WOLK 4) will be available some days after the 2.4.19
final kernel release.


Enjoy!

Marc-Christian Petersen <mcp@linux-systeme.de>
Unix/Linux Administrator
Essen, Germany

