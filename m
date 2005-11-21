Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVKUPIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVKUPIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVKUPIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:08:37 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:6748 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932326AbVKUPIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:08:36 -0500
Subject: Re: what is our answer to ZFS?
From: Kasper Sandberg <lkml@metanurb.dk>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051121144150.GA10189@merlin.emma.line.org>
References: <11b141710511210144h666d2edfi@mail.gmail.com>
	 <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
	 <20051121101959.GB13927@wohnheim.fh-wedel.de>
	 <20051121114654.GA25180@merlin.emma.line.org>
	 <1132574831.15938.14.camel@localhost>
	 <20051121131832.GB26068@merlin.emma.line.org>
	 <1132582713.15938.22.camel@localhost>
	 <20051121144150.GA10189@merlin.emma.line.org>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 16:08:30 +0100
Message-Id: <1132585711.15938.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 15:41 +0100, Matthias Andree wrote:
> On Mon, 21 Nov 2005, Kasper Sandberg wrote:
> 
> > > If the precondition is "adhere to CodingStyle or you don't get it in",
> > > and the CodingStyle has been established for years, I have zero sympathy
> > > with the maintainer if he's told "no, you didn't follow that well-known
> > > style".
> > 
> > that was not the question, the question is if the code is in development
> > phase or not (being stable or not), where agreed, its their own fault
> > for not writing code which matches the kernel in coding style, however
> > that doesent make it the least bit more unstable.
> 
> As mentioned, a file system cannot possibly be stable right after merge.
> Having to change formatting is a sweeping change and certainly is a
> barrier across which to look for auditing is all the more difficult.
before reiser4 was changed alot, to match the codingstyle (agreed, they
have to obey by the kernels codingstyle), it was stable, so had it been
merged there it wouldnt have been any less stable.

> 
> > > I have had, without hard shutdowns, problems with reiserfs, and
> > > occasionally problems that couldn't be fixed easily. I have never had
> > > such with ext3 on the same hardware.
> > > 
> > you wouldnt want to know what ext3 did to me, which reiserfs AND reiser4
> > never did
> 
> OK, we have diametral experiences, and I'm not asking since I trust you
> that I don't want to know, too :) Let's leave it at that.
> 
> > > I don't care what its name is. I am aware it is a rewrite, and that is
> > > reason to be all the more chary about adopting it early. People believed
> > > 3.5 to be stable, too, before someone tried NFS...
> 
> > nfs works fine with reiser4. you are judging reiser4 by the problems
> > reiserfs had.
> 
> Of course I do, same project lead, and probably many of the same
> developers. While they may (and probably will) learn from mistakes,
> changing style is more difficult - and that resulted in one of the major
> non-acceptance reasons reiser4 suffered.
> 
> I won't subscribe to reiser4 specific topics before I've tried it, so
> I'll quit. Same about ZFS by the way, it'll be fun some day to try on a
> machine that it can trash at will, but for production, it will have to
> prove itself first. After all, Sun are still fixing ufs and/or logging
> bugs in Solaris 8. (And that's good, they still fix things, and it also
> shows how long it takes to really get a file system stable.)
> 
> > i have had less trouble by using the reiser4 patches before even hans
> > considered it stable than i had by using ext3.
> 
> Lucky you. I haven't dared try it yet for lack of a test computer to
> trash.
i too was reluctant, i ended up using it for the things i REALLY dont
want to loose.
> 
> > there is quite a big difference between stuff like submount and the
> > filesystem itself.. and as you pointed out, reiserfs in the beginning
> > was a disappointment, do you seriously think they are willing to take
> > the chance again?
> 
> I thing naught about what they're going to put at stake. reiserfs 3 was
> an utter failure for me. It was raved about, hyped, and the bottom line
> was wasted time and a major disappointment.
> 
> > > Yup. So the test and fix cycles that were needed for reiserfs 3.5 and
> > > 3.6 will start all over. I hope the Namesys guys were to clueful as to
> > > run all  their reiserfs 3.X regression tests against 4.X with all
> > > plugins and switches, too.
> > you will find that reiser4 is actually very very good.
> 
> I haven't asked what I'd find, because I'm not searching. And I might
> find something else than you did - perhaps because you've picked up all
> the good things already when I'll finally go there ;-)
> 

