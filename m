Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278709AbRKHHJV>; Thu, 8 Nov 2001 02:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281199AbRKHHJL>; Thu, 8 Nov 2001 02:09:11 -0500
Received: from leeor.math.technion.ac.il ([132.68.115.2]:11171 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S278709AbRKHHJA>; Thu, 8 Nov 2001 02:09:00 -0500
Date: Thu, 8 Nov 2001 09:08:26 +0200 (IST)
From: "Zvi Har'El" <rl@math.technion.ac.il>
To: <arjan@fenrus.demon.nl>
cc: <linux-kernel@vger.kernel.org>, "Nadav Har'El" <nyh@math.technion.ac.il>
Subject: Re: ext3 vs resiserfs vs xfs
In-Reply-To: <E161aYo-0000ch-00@fenrus.demon.nl>
Message-ID: <Pine.GSO.4.33.0111080903360.28492-100000@leeor.math.technion.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Initrd did it! I was not using initrd. I generated the relevant initrd.img and
added the line to my grub.conf configuration, and the problem is solved.
System crashes are now easily recovered.

The only mystery is, why RedHat has ext3fs compiled as a module?

Lot of thanks,

Zvi.

On Wed, 7 Nov 2001 arjan@fenrus.demon.nl wrote:

> In article <Pine.GSO.4.33.0111072302460.12525-100000@leeor.math.technion.ac.il> you wrote:
> > On Wed, 7 Nov 2001, Andreas Dilger wrote:
>
> > /dev/root / ext2 rw 0 0
>
> ext2!
>
> > /dev/hda6 /home ext3 rw 0 0
>
> > How do  fix the situation at this stage? I am using Redhat 7.2 with kernel
> > 2.4.9-13
>
> Be sure to use the initrd as used by default in when you install the kernel.
> Are you using lilo ?   If so add
>
> initrd /boot/initrd-2.4.9-13.img
>
> to the lilo.conf in the relevant kernel section.
>
> Greetings,
>   Arjan van de Ven
>

-- 
Dr. Zvi Har'El     mailto:rl@math.technion.ac.il     Department of Mathematics
tel:+972-54-227607                   Technion - Israel Institute of Technology
fax:+972-4-8324654 http://www.math.technion.ac.il/~rl/     Haifa 32000, ISRAEL
"If you can't say somethin' nice, don't say nothin' at all." -- Thumper (1942)
                          Thursday, 22 Heshvan 5762,  8 November 2001,  9:03AM

