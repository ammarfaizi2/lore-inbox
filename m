Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbTIUPwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 11:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbTIUPwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 11:52:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41884
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262441AbTIUPwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 11:52:34 -0400
Date: Sun, 21 Sep 2003 17:53:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Fix for wrong OOM killer trigger?
Message-ID: <20030921155304.GB29703@velociraptor.random>
References: <20030919203538.D1919@flint.arm.linux.org.uk> <20030919200117.GE1312@velociraptor.random> <20030919205220.GA19830@work.bitmover.com> <20030920033153.GA1452@velociraptor.random> <20030920043026.GA10836@work.bitmover.com> <20030920142314.GA1338@velociraptor.random> <20030920151332.GA18387@work.bitmover.com> <m1smmqjug2.fsf@ebiederm.dsl.xmission.com> <20030921142252.GB16399@velociraptor.random> <20030921145235.GA26186@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921145235.GA26186@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 07:52:35AM -0700, Larry McVoy wrote:
> On Sun, Sep 21, 2003 at 04:22:52PM +0200, Andrea Arcangeli wrote:
> > On Sun, Sep 21, 2003 at 04:40:29AM -0600, Eric W. Biederman wrote:
> > > Careful with your accusations Larry, some of us can answer those questions,
> > > in ways that won't support your argument.
> > 
> > It didn't worth an answer IMHO, he's ignoring lots of efforts going on,
> 
> First of all, I didn't accuse anyone of anything, I asked if you were 
> using open source for in everything that you use each day.  And you
> are ignoring the question.  You stated
> 
> >> I refuse to use closed software myself for my critical tasks true, 
> 
> and I asked
> 
> > So where's the source to the BIOS of your machine?  Your drive
> > firmware?  Do you drive a car?  Turn on a microwave?  Use a cell phone?

I told you none of this is critical to me. they can all break, and I
will throw them away and replace, and most of them cames with a
reasonable warranty anyways.

this is not the case for creative unique data encoded in .doc without a
loss-less converter freely available.

Sure, if I would be maintaining the kernel with a software and a
processor located in the electric injection of fuel board in my car,
then I would pretend that data to be stored in a standard documented
format and the program to be open source (so I can migrate to other
platform instead of the cpu embedded in the car) in the future.

> And you tell me you "will" be running free software on all that soon.
> Until you are, how about you go attack the drive people, the bios people,

I am already using open sources for everything that runs with my
critical data. I turn off acpi as well to be sure the bios don't run (I
only use acpi to do the discovery pci of the devices at boot, I never
allow my box to call into the bios and my data is encrypted on disk so
when the bios runs at boot it has no way to look into it).

>From my point of view, a bug in the bios that destroys the data, is the
same as an hardware bug that corrupts the fs or whatever.

Comparing the worth of a piece of hardware, with ~2 years of development
of hundred of people sounds sounds very stupid.

> recompile kernels, you seem perfectly OK using closed source to play
> quake.  Oh, that's not "critical" because it is for your fun, I see.

Please, I don't play quake, and quake is all but critical. And I think
you couldn't find a worse example anyways since AFIK quake is GPL too
(I'm sure doom was at least open source since I compiled it myself some
year ago).

> If you feel so strongly about closed source then stop using EVERYTHING
> that doesn't have open source in it.  When you have done that, and only 

I already did years ago, my data won't risk to be touched by anything
closed software (when it's in decrypted form).

This is my last email on this topic, I feel these emails don't worth an
answer sorry. It's stunning that you seems really convinced that I'm
making a special case for b*tkeeper or that I'm not coherent with my
view, I've nothing against b*tkeeper, like I've nothing against closed
software at all, infact I always did my best and I will definitely still
do my very best I can, to support all the proprietary software available
for Linux, I do my best to support proprietary binary only extension to
the kernel too infact! But you have no way at all to pretend that I will
be an user of whatever proprietary closed software for anything very
important to me.

And since you didn't mention that I also fly in airplanes that have lots
more software than whatever car. FWIW I definitely think lots of
software critical for lives like the ones that is meant to avoids
collisions between airplanes should be open source.  If there's a bug I
definitely prefer that people is able to find it and fix it. We know
from practice that security through obscurity can lead to disasters in
the long run.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
