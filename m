Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313776AbSDPTmC>; Tue, 16 Apr 2002 15:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313780AbSDPTmB>; Tue, 16 Apr 2002 15:42:01 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:20748 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313776AbSDPTmA>; Tue, 16 Apr 2002 15:42:00 -0400
Subject: Re: [ANNOUNCE] Kernel 2.4.18-WOLK3.3
From: Tommy Faasen <faasen@xs4all.nl>
To: mcp@linux-systeme.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204032254.g33MsudC028678@codeman.linux-systeme.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 23:49:50 +0200
Message-Id: <1018993790.3780.0.camel@it0>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-08 at 09:33, Marc-Christian Petersen wrote:

I got the following error

ch.c:92: unknown field `major' specified in initializer
ch.c:92: warning: initialization makes pointer from integer without a
cast
ch.c: In function `init_ch_module':
ch.c:868: parse error before `UTS_RELEASE'
make[3]: *** [ch.o] Error 1
make[3]: Leaving directory `/mnt/temp/linux/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/mnt/temp/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/mnt/temp/linux/drivers'
make: *** [_dir_drivers] Error 2

What should I do?

> Kernel - patched - WOLK3.3 - Base: Linux kernel 2.4.18
> 
> by Marc-Christian Petersen <mcp@linux-systeme.de>
> 
> 
> WOLK 3.3 contains minimal bugfixes found in WOLK 3.2 reported by
> users of wolk and found by myself and some new adds/updates which
> can be found in the changelog.
> 
> Thanks to darix <darix@irssi.de> for the project name WOLK :-)
> 
> 
> What is this? Why another patchset/patched kernel?
> 
> Using Linux since years, very tired of there are not really good
> patchsets available. Saw FOLK Patch/Kernel which is still very very buggy.
> 
> Inspired by the jp-Patchsets from Joerg Prante <joerg@infolinux.de>.
> 
> 
> The WOLK's are development kernels/patchsets for testing purpose only.
> !! If you want to use it in production, use it at your own risk !!
> Their purpose is to provide a service for developers and end-users who
> can't be up to date with the latest official stable kernels/patches but
> want to test many features out there linux can use. Maybe, (hopefully)
> some of them will be included into the mainstream kernel 2.4 soon.
> 
> There will always be a new WOLK major release if there is a new final
> kernel released. Minor releases only if someone/me found critical bugs,
> or in case of some adds.
> 
> You are missing a patch? Patches will be added by request.
> You think one or more of the patches are fully useless? Tell me why.
> You have minor, major or heavy mega problems, let me know. I will try to fix.
> You think this is great? Let me know too :-)
> You've found a bug? Report it!!
> 
> You want YOUR patch to be included in WOLK? Let me know :)
> Please send your merge against this release to me in that case.
> 
> You want to join this project as a developer? Let me know too!
> I need help in successfully applying rmap and O(1) scheduler with all
> the other patches in this set !
>    
> There is also a mailinglist available you can join at:
> https://sourceforge.net/mail/?group_id=49048
> 
> 
> Some of the features:
> ---------------------
> grsecurity, crypto, win4lin, xfs, kdb, jfs, kdb, preempt, freeswan(ipsec),
> IPVS, i2c/lmsensors, tux, uml, ltt, compressed cache, evms, badmem, ABI,
> software suspend, supermount, ACPI, ALSA ... and many more.
> 
> 
> Overview:
> ---------
> For a complete overview go to http://sf.net/projects/wolk
> The full list of patches is http://prdownloads.sf.net/wolk/WOLK-OVERVIEW
> The WOLK 3.3 kernel/patchset contains over 100 Patches.
> 
> Credits go to all the people who created the patches, working hard on
> improving the quality.
> 
> 
> Changes in WOLK 3.3
> -------------------
> 
> o   add:        SBcard no-hlt
> 
> o   add:        Page Coloring
> 
> o   add:        ALSA v0.9.0beta12 with NO Kernel-Sound-Drivers-remove, so you
>                 can choose between ALSA and Standard Kernel Sound Drivers.
>                 (request by Kathrin Gutenberg <K.Gutenberg@noreply.org>)
> 
> o   add:        arch/i386/mm/init.c cleanup Patch, so its human readable and
>                 working, if config is minimal.
>                 (Reported/fixed by Waldemar Brotkorb <waldemar@thinknow.de>)
> 
> o   add:        Patch for ACPI (April 4th, 2002), cause if ACPI was not
> 		defined kernel does not compile. Simple ifdefs does the job :)
>                 In other words: we don't want to force the user to use ACPI :)
>                 (Reported/fixed by Waldemar Brotkorb <waldemar@thinknow.de>)
> 
> o   add:        USBDNET (Ethernet over USB)
>                 (request by Peter Andres <PAndres@t-online.de>)
> 
> o   add:        Stream Control Transmission Protocol (SCTP)
> 
> o   update:     CDfs v0.5c
> 
> o   update:     real BUG ON Patch (missed the 2nd Part in WOLK3.2)
> 
> o   update:     UML (UserModeLinux -14)
> 
> o   update:     ACPI (April 4th, 2002)
> 
> 
> --------------------------------------------------------------------------
> Feel free to send me feedback. Please CC, I am not subscribed to the lkml.
> --------------------------------------------------------------------------
> 
> 
> The next major WOLK (WOLK 4) will be available some days after the 2.4.19
> final kernel release.
> 
> 
> Enjoy!
> 
> Marc-Christian Petersen <mcp@linux-systeme.de>
> Unix/Linux Administrator
> Essen, Germany
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


