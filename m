Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281070AbRKYVQr>; Sun, 25 Nov 2001 16:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281069AbRKYVQh>; Sun, 25 Nov 2001 16:16:37 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:59154 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S281063AbRKYVQW>; Sun, 25 Nov 2001 16:16:22 -0500
Date: Sun, 25 Nov 2001 22:16:19 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.13 Kernel and Ext3 vs Ext2
In-Reply-To: <20011125144902.A9714@fenrus.demon.nl>
Message-ID: <Pine.LNX.4.33.0111252200580.9956-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001, Arjan van de Ven wrote:

> On Mon, Nov 26, 2001 at 12:28:27AM +1000, James Davies wrote:
> > On Sun, 25 Nov 2001 23:37, arjan@fenrus.demon.nl wrote:
> > > In article <20011125132713Z280878-17408+19757@vger.kernel.org> you wrote:
> > > > You can also download a kernel RPM. the latest one released by redhat is
> > > > 2.4.13, and it is pretty much guaranteed to work with your current system
> > > > and not break anything. It is also be patched with ext3 support.
> > >
> > > Ehmmm..... The last released kernel by Red Hat is 2.4.9-13, not
> > > 2.4.13-something....
> > 
> > ftp://rpmfind.net/linux/rawhide/1.0/i386/RedHat/RPMS/kernel-2.4.13-0.6.i386.rpm
> 
> rawhide != released !!!!!
> rawhide is a weekly development snapshot that is taken at basically a random
> time. Those kernels have seen no QA and are untested, they might not even
> boot.

That's only half of the truth. Go and search bugzilla at Red Hat. They
have many bugs in a 'fixed in Rawhide' status. 

I see that having a 'not yet QA-tested' fix it's better than not having it
at all, but it's also true that they mark the bug 'CLOSED' after putting it
in 'fixed in Rawhide' state. IMHO, that's quite an official statement
about the bug itself.  It means go and use rawhide (not as a whole,
of course).  They should leave the bug OPEN until an official *errata*
exists.  Otherwise, people get the idea that rawhide == errata. Thus,
kind of released.

> You're very welcome to help betatest them, and I welcome all bugreports
> against them; however considering them as released... no

Ehm, I admit the above might not be true for *kernel* rpms. I'm not
aware of any major kernel bug that has been fixed in rawhide and *not*
in errata.  But rahwide is more than a just random snapshot, it's also
a place to look for fixes. I mean, a place where Red Hat officially says
you should be looking for fixes. A simple search on bugzilla shows 
78 CLOSED bugs with resolution == RAWHIDE (it may be just an update
problem, of course). I hope the 'you keep the pieces' things is not true
for 'CLOSED' bugs.

But this is quite OT, of course. Please move further discussion to 
private mail.

> 
> Greetings,
>    Arjan van de Ven
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

.TM. - a happy Red Hat user

