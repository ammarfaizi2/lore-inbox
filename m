Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLOVLE>; Fri, 15 Dec 2000 16:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbQLOVKy>; Fri, 15 Dec 2000 16:10:54 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:27659 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129319AbQLOVKi>; Fri, 15 Dec 2000 16:10:38 -0500
Date: Fri, 15 Dec 2000 21:37:27 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@suse.cz>
cc: Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <20001215212601.A26758@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.96.1001215212408.16023A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > For one of our demos, we ran a file server on a remote linux box (that we 
> > > > just had a user account on), mounted it on a kORBit'ized box, and ran
> > > > programs on SPARC Solaris that accessed the kORBit'ized linux box's file
> > > > syscalls.  If nothing else, it's pretty nifty what you can do in little
> > > > code...
> > > 
> > > Cool!
> > > 
> > > However, can you do one test for me? Do _heavy_ writes on kORBit-ized
> > > box. That might show you some problems.
> > 
> > I guess that when you mmap large files over nfs and write to them, you get
> > similar problems.
> > 
> > > Oh, and try to eat atomic memory by ping -f kORBit-ized box.
> > 
> > When linux is out of atomic memory, it will die anyway.
> 
> Why should it die?

Because it is written badly :-(

> It is quite easy to make machine run out of atomic
> memory: just bomb it with lots of packets. It should recover, eventually

Mikulas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
