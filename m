Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266674AbRG1OOq>; Sat, 28 Jul 2001 10:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266682AbRG1OOg>; Sat, 28 Jul 2001 10:14:36 -0400
Received: from smtp010.mail.yahoo.com ([216.136.173.30]:27655 "HELO
	smtp010.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266674AbRG1OOV>; Sat, 28 Jul 2001 10:14:21 -0400
X-Apparently-From: <kiwiunixman@yahoo.co.nz>
Content-Type: text/plain; charset=US-ASCII
From: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
To: bvermeul@devel.blackstar.nl, Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Date: Sun, 29 Jul 2001 02:13:03 +1200
X-Mailer: KMail [version 1.2]
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl>
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl>
MIME-Version: 1.0
Message-Id: <01072902123101.02683@kiwiunixman.nodomain.nowhere>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Saturday 28 July 2001 01:24, bvermeul@devel.blackstar.nl wrote:
> On Fri, 27 Jul 2001, Hans Reiser wrote:
> > bvermeul@devel.blackstar.nl wrote:
> > > On Wed, 18 Jul 2001, Erik Mouw wrote:
> > > > On Wed, Jul 18, 2001 at 03:18:59PM +1000, Steve Kieu wrote:
> > > > > My advice:
> > > > >
> > > > > Dont use reiserfs,JFS
> > > > > it is ok to use ext2
> > > > >
> > > > > Go journalling? use ext3 or XFS
> > > > >
> > > > > I have used  all of these fs and pick up this rule (up
> > > > > to now, not sure it remains right in the far  future)
> > > >
> > > > FUD. I've been using reiserfs on quite some systems and never got any
> > > > problem. If reiserfs wouldn't be stable, SuSE wouldn't have supported
> > > > it as one of their stable filesystems for over a year.
> > >
> > > Actually, I've been having some nasty corruption problems as well with
> > > reiserfs. I develop my own drivers, and do occasionally make a mistake,
> > > and when that hangs the kernel it will also screw up all files touched
> > > just before it in a edit-make-install-try cycle. Which can be rather
> > > annoying, because you can start all over again (this effect randomly
> > > distributes the last touched sectors to the last touched files. Very
> > > nice effect, but not something I expect from a journalled filesystem).
> >
> > Do you think it is reasonable to ask that a filesystem be designed to
> > work well with bad drivers?
>
> Yup. I know ext2 can do it. I expect a filesystem to not foul up my data
> when something happens. Especially not shuffle around sectors in several
> files. I can understand that the changes I made are not on disc, I can
> even understand it if my files are gone, but not when it corrupts my data.
> That just plain sucks.
>
> A friend of mine has had crashes as well (not reiser related btw), where
> files he was using at the time suddenly contained different pieces of
> different files. It's just plain annoying. The reason why *I* use(d)
> reiserfs was the fact that I thought that it would protect my data when
> something does crash. From my experience, it doesn't, and I'd rather wait
> a couple of minutes for ext2 to fsck than use reiserfs and be sure I can
> start all over again.
>
> Regards,
>
> Bas Vermeulen

What chipset have you got? I am running a PIII 550 w/ Intel BX chipset and 
ReiserFS (Kernel 2.4.7) and haven't run into any problems. Have you tried 
just sticking with the generic IDE driver and wait until the chipset specific 
driver becomes more stable?

Matthew Gardiner

-- 
WARNING:

This email was written on an OS using the viral 'GPL' as its license.

Please check with Bill Gates before continuing to read this email/posting.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

