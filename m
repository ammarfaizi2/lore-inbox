Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLORtB>; Fri, 15 Dec 2000 12:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLORsv>; Fri, 15 Dec 2000 12:48:51 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:26887 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S129183AbQLORsn>;
	Fri, 15 Dec 2000 12:48:43 -0500
Date: Fri, 15 Dec 2000 09:54:49 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <20001214210245.B468@bug.ucw.cz>
Message-ID: <Pine.LNX.4.21.0012150953050.29507-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For one of our demos, we ran a file server on a remote linux box (that we 
> > just had a user account on), mounted it on a kORBit'ized box, and ran
> > programs on SPARC Solaris that accessed the kORBit'ized linux box's file
> > syscalls.  If nothing else, it's pretty nifty what you can do in little
> > code...
> 
> Cool!
> 
> However, can you do one test for me? Do _heavy_ writes on kORBit-ized
> box. That might show you some problems. Oh, and try to eat atomic
> memory by ping -f kORBit-ized box.

I'll give that a try when I get a chance.  :)

> I've always wanted to do this: redirect /dev/dsp from one machine to
> another. (Like, I have development machine and old 386. I want all
> programs on devel machine use soundcard from 386. Can you do that?)

Yes.  Definately.  There are probably other ways of doing that... but one
of the things we implemented was a "generic" character device... and we
tested it by having a chardev server that basically reads from a
"local" (to the server) character device, and forward it over CORBA.  So
this is already implemented!  :)

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
