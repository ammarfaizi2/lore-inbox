Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265268AbSKEEAp>; Mon, 4 Nov 2002 23:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266235AbSKEEAo>; Mon, 4 Nov 2002 23:00:44 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:45712 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265268AbSKEEAm>; Mon, 4 Nov 2002 23:00:42 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 4 Nov 2002 20:17:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Skip Ford <skip.ford@verizon.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.46
In-Reply-To: <200211050401.gA541YPi006905@pool-141-150-241-241.delv.east.verizon.net>
Message-ID: <Pine.LNX.4.44.0211042016050.956-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002, Skip Ford wrote:

> Kai Germaschewski wrote:
> > On Mon, 4 Nov 2002, george anzinger wrote:
> >
> > > I think we need a newer objcopy :(
> >
> > Alternatively, use this patch. (It's not really needed to force people to
> > upgrade binutils when ld can do the job, as it e.g. does in
> > arch/i386/boot/compressed/Makefile already).
> >
> > -	( cd $(obj) ; ./gen_init_cpio | gzip -9c > initramfs_data.cpio.gz )
> > +	( cd $(obj) ; ./$< | gzip -9c > $@ )
>
> I get errors with your patch.  I had to remove the 'cd $(obj)' above
> from usr/Makefile.

With the latest binutils it works flawlessy w/out any patches ...



- Davide


