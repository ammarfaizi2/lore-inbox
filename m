Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131051AbQLOU5P>; Fri, 15 Dec 2000 15:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131139AbQLOU5F>; Fri, 15 Dec 2000 15:57:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56075 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131051AbQLOU4v>; Fri, 15 Dec 2000 15:56:51 -0500
Date: Fri, 15 Dec 2000 21:26:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Pavel Machek <pavel@suse.cz>, Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
Message-ID: <20001215212601.A26758@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20001214210245.B468@bug.ucw.cz> <Pine.LNX.3.96.1001215205918.13941A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.3.96.1001215205918.13941A-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Fri, Dec 15, 2000 at 09:10:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > For one of our demos, we ran a file server on a remote linux box (that we 
> > > just had a user account on), mounted it on a kORBit'ized box, and ran
> > > programs on SPARC Solaris that accessed the kORBit'ized linux box's file
> > > syscalls.  If nothing else, it's pretty nifty what you can do in little
> > > code...
> > 
> > Cool!
> > 
> > However, can you do one test for me? Do _heavy_ writes on kORBit-ized
> > box. That might show you some problems.
> 
> I guess that when you mmap large files over nfs and write to them, you get
> similar problems.
> 
> > Oh, and try to eat atomic memory by ping -f kORBit-ized box.
> 
> When linux is out of atomic memory, it will die anyway.

Why should it die? It is quite easy to make machine run out of atomic
memory: just bomb it with lots of packets. It should recover, eventually

> 
> Mikulas
> 
> 

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
