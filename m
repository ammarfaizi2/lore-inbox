Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266253AbSKEEIq>; Mon, 4 Nov 2002 23:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbSKEEIq>; Mon, 4 Nov 2002 23:08:46 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:58026 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S266253AbSKEEIo>; Mon, 4 Nov 2002 23:08:44 -0500
Message-Id: <200211050412.gA54CpPi011677@pool-141-150-241-241.delv.east.verizon.net>
Date: Mon, 4 Nov 2002 23:12:49 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.46
References: <200211050401.gA541YPi006905@pool-141-150-241-241.delv.east.verizon.net> <Pine.LNX.4.44.0211042016050.956-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211042016050.956-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Mon, Nov 04, 2002 at 08:17:04PM -0800
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [141.150.241.241] at Mon, 4 Nov 2002 22:15:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Mon, 4 Nov 2002, Skip Ford wrote:
> > Kai Germaschewski wrote:
> > > On Mon, 4 Nov 2002, george anzinger wrote:
> > >
> > > > I think we need a newer objcopy :(
> > >
> > > Alternatively, use this patch. (It's not really needed to force people to
> > > upgrade binutils when ld can do the job, as it e.g. does in
> > > arch/i386/boot/compressed/Makefile already).
> > >
> > > -	( cd $(obj) ; ./gen_init_cpio | gzip -9c > initramfs_data.cpio.gz )
> > > +	( cd $(obj) ; ./$< | gzip -9c > $@ )
> >
> > I get errors with your patch.  I had to remove the 'cd $(obj)' above
> > from usr/Makefile.
> 
> With the latest binutils it works flawlessy w/out any patches ...

His patch is intended to negate the need for a recent binutils.  I
already have binutils 2.13 and had no trouble building.  But with his
patch that I assume Linus will apply, it errors out no matter which
binutils you have.

-- 
Skip
