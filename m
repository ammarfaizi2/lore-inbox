Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275571AbRJLKCX>; Fri, 12 Oct 2001 06:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277277AbRJLKCN>; Fri, 12 Oct 2001 06:02:13 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:49711 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S275571AbRJLKCC>; Fri, 12 Oct 2001 06:02:02 -0400
Date: Fri, 12 Oct 2001 13:02:06 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: "T. A." <tkhoadfdsaf@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which kernel (Linus or ac)?
Message-ID: <20011012130206.E1074@niksula.cs.hut.fi>
In-Reply-To: <XFMail.20011011094548.jkp@riker.nailed.org> <3BC5E152.3D81631@bigfoot.com> <3BC5E3AF.588D0A55@lexus.com> <OE22ITtCsuSYkbAY0Jp0000df3f@hotmail.com> <20011012095618.R22640@niksula.cs.hut.fi> <OE26nfAMxUtDjTZZTTu0000e302@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OE26nfAMxUtDjTZZTTu0000e302@hotmail.com>; from tkhoadfdsaf@hotmail.com on Fri, Oct 12, 2001 at 05:25:32AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 05:25:32AM -0400, you [T. A.] claimed:
> >
> > Of course, you can get most of the IDE chipset support, fs support
> (reiserfs
> > 3.5, ext3) and LFS support as patches for 2.2:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.19/
> 
>     Have used this and has worked great on the machines I've had to use it
> on.  Though I'm a bit leery about using it since I figure the generic
> 2.2.x.preX kernels get a lot more testing that those with this patch
> installed.  Also heard of problems using this patch on a VIA PIII SMP
> system. :-(  And just went I had been planning to use it on a dual PIII VIA
> chipset board too.

I've used it on multiple 2.2 systems as well (Dual Celeron/BX400++HPT366,
Via/Duron, PII/BX440 etc) and never had a problem.

> ftp://ftp.namesys.com/pub/reiserfs-for-2.2/linux-2.2.19-reiserfs-3.5.34-patc
> h.bz2
> 
>     I actually was going to start using this until I learned that 2.2.x
> reiser patched kernels couldn't use reiserfs partitions made with 2.4.

Yeah.

I've used it for a long time and only once had a small issue with it (which
didn't impose data corruption, just one app (UML) didn't work since mmap on
old 2.2 reiser was somewhat broken).

> :-(  Ended up having to redo an entire system when a downgrade to 2.2.x
> became imperitive.  Also the 2.2.x reiser patch lacks the large file support
> (on the reiser filesystems created under 2.2.x) and maybe other goodies and

I thought you could get LFS on reiser on 2.2 with the LFS patch and some
patch to reiser? I'm not sure though. SuSE did ship with 2.2, reiser and
large file support...

> > http://moldybread.net/patch/kernel-2.2/linux-2.2.19-lfs-1.0.diff.gz
> 
>     I'll look into this the next time > 2GB files support becomes needed on
> a system.  pre 2.4.x I had been using FreeBSD for such tasks.

Nowdays, though, I think I 2.4 is beginning to be stable enough for just
about anything. The first 2.4 kernels were terrible wrt vm - they'd go ahead
killing innocent daemons when I did a simple diff -R /usr/src/linux
/usr/src/linux2 with hundreds of MBs free RAM.


-- v --

v@iki.fi
