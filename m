Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277609AbRJLJ1S>; Fri, 12 Oct 2001 05:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277614AbRJLJ1I>; Fri, 12 Oct 2001 05:27:08 -0400
Received: from oe26.law9.hotmail.com ([64.4.8.83]:37124 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S277609AbRJLJ05>;
	Fri, 12 Oct 2001 05:26:57 -0400
X-Originating-IP: [66.108.21.174]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Ville Herva" <vherva@mail.niksula.cs.hut.fi>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <XFMail.20011011094548.jkp@riker.nailed.org> <3BC5E152.3D81631@bigfoot.com> <3BC5E3AF.588D0A55@lexus.com> <OE22ITtCsuSYkbAY0Jp0000df3f@hotmail.com> <20011012095618.R22640@niksula.cs.hut.fi>
Subject: Re: Which kernel (Linus or ac)?
Date: Fri, 12 Oct 2001 05:25:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE26nfAMxUtDjTZZTTu0000e302@hotmail.com>
X-OriginalArrivalTime: 12 Oct 2001 09:27:23.0610 (UTC) FILETIME=[198163A0:01C15300]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Of course, you can get most of the IDE chipset support, fs support
(reiserfs
> 3.5, ext3) and LFS support as patches for 2.2:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.19/

    Have used this and has worked great on the machines I've had to use it
on.  Though I'm a bit leery about using it since I figure the generic
2.2.x.preX kernels get a lot more testing that those with this patch
installed.  Also heard of problems using this patch on a VIA PIII SMP
system. :-(  And just went I had been planning to use it on a dual PIII VIA
chipset board too.

>
>
ftp://ftp.namesys.com/pub/reiserfs-for-2.2/linux-2.2.19-reiserfs-3.5.34-patc
h.bz2

    I actually was going to start using this until I learned that 2.2.x
reiser patched kernels couldn't use reiserfs partitions made with 2.4.
:-(  Ended up having to redo an entire system when a downgrade to 2.2.x
became imperitive.  Also the 2.2.x reiser patch lacks the large file support
(on the reiser filesystems created under 2.2.x) and maybe other goodies and
I don't get that back easily by just switching kernels.

> ftp://ftp.kernel.org/pub/linux/kernel/people/sct/ext3/

    Might give this a try now that it appears to be release quality.

> http://moldybread.net/patch/kernel-2.2/linux-2.2.19-lfs-1.0.diff.gz

    I'll look into this the next time > 2GB files support becomes needed on
a system.  pre 2.4.x I had been using FreeBSD for such tasks.
