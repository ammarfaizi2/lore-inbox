Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314108AbSDKPlL>; Thu, 11 Apr 2002 11:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314106AbSDKPlK>; Thu, 11 Apr 2002 11:41:10 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:10430 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S314098AbSDKPlI>; Thu, 11 Apr 2002 11:41:08 -0400
From: "Jordan Breeding" <jordan.breeding@attbi.com>
To: "'Daniel Gryniewicz'" <dang@fprintf.net>,
        "'Nicholas Berry'" <nikberry@med.umich.edu>
Cc: <aab@cichlid.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Tyan S2462 reboot problems
Date: Thu, 11 Apr 2002 15:40:54 -0000
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAjQHXypTRWUeX0Da3WGxUUMKAAAAQAAAAEpeHJi0FGkuFcuTh+tLQxAEAAAAA@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
In-Reply-To: <20020410144508.48a1a482.dang@fprintf.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Tyan Thunder K7 (S2462UNG).  I run with the onboard video
jumpered to off and a ATI Radeon 7500 AGP in the AGP slot.  Windows and
FreeBSD install, run, reboot, and shutdown just fine.  Linux will
install and run fine, but then when it reboots the screen hangs (no new
output -- the last words on the screen are "Rebooting now." or something
similar) and then the hd activity light on my case comes on solid for
the ECC test of the RAM even though the screen has still not been
cleared, then as the post messages come up they are very jumbled,
complete video corruption and the corruption does not go away until
either Windows or XFree86 loads completely (which ever is currently my
default OS).  This problem occurs with the RedHat 7.2 (the one on the
disc) kernel, the RedHat 7.2.93 kernel, and the gentoo 1.0 kernel.  I
have not tried any others yet.  I run with either no frame buffer at all
or if I use one I use the in kernel radeonfb driver, either way the
corruption happens.  I wouldn't have though twice about Windows being
successful at this since it often has odd fixed for odd problems, but
the thing that really got me wondering about this is that FreeBSD seems
to not have any issues rebooting/halting this machine.  Thanks for any
information you all might have about what is going on.

Jordan

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Daniel Gryniewicz
> Sent: Wednesday, April 10, 2002 18:45
> To: Nicholas Berry
> Cc: aab@cichlid.com; linux-kernel@vger.kernel.org
> Subject: Re: Tyan S2462 reboot problems
> 
> 
> Hercules 4500 (Kyro II).  I run the Vesa drivers, as I don't 
> run any of the distro's that have beta drivers, and I do have 
> video corruption occasionally, but not very often (and never 
> in Windows).
> 
> Daniel
> 
> On Wed, 10 Apr 2002 12:21:03 -0400
> "Nicholas Berry" <nikberry@med.umich.edu> wrote:
> 
> > What display adapter are you using? BIOS's earlier than 
> 1.04 screwed 
> > up
> royally with ATI Radeon 8500/7500 cards - actually, so does 
> 1.04, but not as much. I've also noticed that Radeon + 
> Adaptec 39160 corrupts video where without the Adaptec it 
> doesn't. Strange.> 
> > Nik
> > 
> > (This is on the 2460, not 2462)
> > 
> > >>> Daniel Gryniewicz <dang@fprintf.net> 04/09/02 04:14PM >>>
> > > Hi.
> > 
> > > No, I doubt this has anything to do with Linux.   I have 
> a S2460 (which
> his> > corrected post says he has), which does not power down under 
> his> > linux, and
> > > *never* warm boots cleanly.  It does power down under 
> windows, so I 
> > > assume ACPI powerdown works and APM does not.  I have 
> gone under the 
> > > assumption
> that> > a BIOS upgrade will fix this, but that involves 
> putting a floppy 
> that> > into
> the box,> > so I haven't done it yet.  The warm boot problems 
> consist of either a hang> > after POST (but before 
> bootloader, OS irrelevent), or really bad video> > 
> corruption.  I don't know if it boot with the video 
> corruption, I've never let> > it try.
> > 
> > > Daniel
> 
> 
> --- 
> Recursion n.:
>         See Recursion.
>                         -- Random Shack Data Processing Dictionary
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

