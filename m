Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130929AbRAYSyo>; Thu, 25 Jan 2001 13:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135965AbRAYSy2>; Thu, 25 Jan 2001 13:54:28 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:11272 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S130929AbRAYSyN>; Thu, 25 Jan 2001 13:54:13 -0500
Message-ID: <3A7076E3.D9E6AF8B@ngforever.de>
Date: Thu, 25 Jan 2001 11:56:35 -0700
From: Thunder from the hill <thunder@ngforever.de>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD QXW03240  (WinNT; U)
X-Accept-Language: de,en-US
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
CC: linux-kernel@vger.kernel.org
Subject: Re: vfat <-> vfat copying of ~700MB file, so slow!
In-Reply-To: <20010124131431.A19957@ikar.t17.ds.pwr.wroc.pl> <997u6tsn18dp9u1h97q4j5jc9a2amn1nsp@i-vic.net> <20010124193525.A28379@ikar.t17.ds.pwr.wroc.pl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz wrote:
> 
> On/Dnia Wed, Jan 24, 2001 at 12:23:03PM -0600, Brad Felmey wrote/napisa³(a)
> > > I/O support  =  0 (default 16-bit)
> >
> > hdparm -c1 /dev/hda, or are you running in 16-bit mode on purpose?
> no purpose. Setting this can only speed up all operations a bit but it doesn't
> change nothing in vfat <-> vfat copying. It still slows down while copying.
I noticed the kernel to increase cache and let the buffers break down during long file copies, it seems like this is the wrong way if only copying one large file. This also happens on SMB connections. I don't know if this info is useful.

Thunder
---
I did a "cat /boot/vmlinuz >> /dev/audio" - and I think I heard god...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
