Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283002AbRLWBQ2>; Sat, 22 Dec 2001 20:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283048AbRLWBQU>; Sat, 22 Dec 2001 20:16:20 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:2053 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S283003AbRLWBQC>; Sat, 22 Dec 2001 20:16:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sat, 22 Dec 2001 20:15:47 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0112180350550.6100-100000@weyl.math.psu.edu> <E16HwgA-0001uk-00@schizo.psychosis.com> <3C252861.3090600@zytor.com>
In-Reply-To: <3C252861.3090600@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16HxEq-00029F-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 December 2001 19:42, H. Peter Anvin wrote:
> Dave Cinege wrote:
> > On Tuesday 18 December 2001 14:10, H. Peter Anvin wrote:
> >>Note that Al is working on a replacement; he's not just bitching.  The
> >>replacement is called "initramfs" which means populating a ramfs from
> >>an archive or collection of archives passwd by the bootloader.  With
> >>that in there, lots of things can be done in userspace.
> >
> > Already done for many months (actully years) now. If I thought it
> > would be accepted, I'd gut rd.c and fully merge it into a 2.5 patch.
>
> Viro's going quite a bit beyond this, though.

Disaster is the word that comes to mind when I think about the last
initramfs patch I looked at (be it several months ago)

> Also, a big key is the
> ability to have multiple images, some of which may not be compressed.

Initrd Dynamic already supports multiple tar.gz archives. If I thought
their was a need I could support uncompressed tar's with a few small
changes.

I've patched GRUB to support loading the mutiple images. It would also
be supported in syslinux, if you choose to implement it. Months
ago when I asked you to implement it, you told me the idea was
stupid.  : P   I will never let you forget this myopia. : >

Dave

-- 
The time is now 22:54 (Totalitarian)  -  http://www.ccops.org/
