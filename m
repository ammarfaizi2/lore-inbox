Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318407AbSHKVhu>; Sun, 11 Aug 2002 17:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318399AbSHKVht>; Sun, 11 Aug 2002 17:37:49 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53003
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318407AbSHKVht>; Sun, 11 Aug 2002 17:37:49 -0400
Date: Sun, 11 Aug 2002 14:32:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
cc: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org
Subject: Re: 2.4.19 eat my disc (contents)
In-Reply-To: <20020811184356.GC755@gallifrey>
Message-ID: <Pine.LNX.4.10.10208111426210.3940-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David,

Well before you start pointing bogus fingers again, you need to be sure.
Now since I only use -ac patches as a base, I do know there could be some
issues, but you can not execute that code path.  It is disabled.

If it eats Alpha, there are way more people then you who would be eating
my shorts and kicking my arse.

Cheers,

On Sun, 11 Aug 2002, Dr. David Alan Gilbert wrote:

> * Paul Slootman (paul@debian.org) wrote:
> > On Sun 11 Aug 2002, Dr. David Alan Gilbert wrote:
> > 
> > >   I've just lost the contents of my disc on my Alpha to 2.4.19 - be
> > 
> > That's not absolutely sure...
> > 
> > > All tools were from Debian/unstable; updated immediatly prior to the 
> > > kernel build.
> > 
> > It could of course be that during the update something trashed some
> > part of the disk, which only made itself apparent after the reboot.
> > 
> > Golden rule: only change one thing at a time...
> 
> Sure; it was just a standard apt-get dist-upgrade (since I'd not run the
> upgrade for a few weeks); not a major potato->woody transition or
> anything.
> 
> > My alpha's been running 2.4.19-rc2 for more than 3 weeks now without any
> > problems (the kernel also has my patches against unaligned accesses in
> > the kernel, for the packet filter and for netfilter).  I don't think
> > anything big would have been changed between rc2 and the final release,
> > so unless it's specific to the IDE driver (I use SCSI) I doubt the
> > kernel is the culprit.
> 
> I suspect the IDE driver; but that is difficult to tell.
> 
> Dave
>  ---------------- Have a happy GNU millennium! ----------------------   
> / Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
> \ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

