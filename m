Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292454AbSBPRfT>; Sat, 16 Feb 2002 12:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292458AbSBPRfK>; Sat, 16 Feb 2002 12:35:10 -0500
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:32983
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S292454AbSBPRe4>; Sat, 16 Feb 2002 12:34:56 -0500
Date: Sat, 16 Feb 2002 12:34:41 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        That Linux Guy <thatlinuxguy@hotmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <20020216110857.B32129@thyrsus.com>
Message-ID: <Pine.LNX.4.44.0202161156350.16872-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2002, Eric S. Raymond wrote:

> Nicolas Pitre <nico@cam.org>:
> > Do you copy?  Please acknoledge that you listened to this very feedback.
> 
> I listened.

Good.  We therefore can make progress.
By your comments below we now know that you listened and that it's 
extremely painful for you to admit the truth.  But you must understand the 
nuances if you want to go somewhere with CML2.

> Would you ask someone designing a new VM to make it crash and hang exactly
> the same way the old one did?
> 
> Do you demand that a rewrite of a disk driver have the same data-corruption
> bugs as the original before it can go into the tree, and tell the developer
> to add fixes later?

Your examples are flawed.  The person who fix bugs in the VM doesn't use any 
other language than the original one.  The person who do a rewrite of a disk 
driver doesn't change anything in the struct rational purpose of reading and 
writing blocks of bytes on a media.

> Pragmatically, the point of rewriting a system is to *fix bugs*.

Indeed!  However CML2 is __way__ more than only bug fixing.  If you qualify 
your current CML2 inclusion proposal as only "bug fixes" it's much too much 
under estimating the work you did and the effort you put in it.

I'm sure people will agree with the fact that the CML2 syntax is much more 
enjoyable to read and work with.  The fact that all frontends are using the 
same parser eliminates bugs already.  That's the part most people have 
nothing against.  For god sake submit those parts and leave the rest for a 
later discussion!

Admit that in the tremendous work you did, there are parts that people will 
disagree with.  Don't spoil it all by not separating things and only 
presenting it as a big unknown blat!

For people to have confidence in CML2 it must be proposed in multiple 
incremental changes -- changes that are small enough (either conceptually or 
physically) for people to be able to grok them without too much effort.  You 
must also be prepared to see people wanting to modify things in some ways 
you didn't think about along the process.  That's why only producing a 
strict CML1 --> CML2 translation would already be a big enough step for now.

> Let's suppose we ignored this point for a moment.  Let's also suppose
> that what you were demanding were not rendered horribly painful and
> perhaps impossible by the difference between CML1's imperative style
> and CML2's declarative one.

Do what's necessary so the translation is a near as possible and the result 
in say 'make config' is the same (same questions as before).  You certainly 
can do that with some bits of awk.  If you can't come with something 
similar, you're then already admiting yourself that CML2 is so big a change 
that people are right to be afraid of it.

> How the hell do you possibly think I could possibly stay motivated under
> that constraint?  Nobody is paying me to do this.  I'm a volunteer; I
> need to produce good art, not waste time slavishly recreating old errors
> just because a few people are unreasonably fearful of change.

First, by doing what I described above, you'll please more people than you 
can imagine.  Next you must be prepared to face the possibility that your 
art might not be adopted integrally.  You should be motivated by the 
percentage that gets adopted in the end.

When Al Viro decides to rewrite the VFS, he doesn't submit it to Linus as a
single big opaque patch to replace the old code at once.  If he did, he
would probably still be waiting for Linus to merge his art.

Note the nuance:  we don't criticize your art but rather the way you present 
it.  It might be the best configuration tool ever, but untroduce it in 
incremental steps and leave some slack between them for those who didn't 
work on it for the last year to digest them.  Please be wise so not to waste 
your art.


Nicolas

