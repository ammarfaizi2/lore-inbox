Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264641AbRFUB4S>; Wed, 20 Jun 2001 21:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbRFUB4J>; Wed, 20 Jun 2001 21:56:09 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:53706 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S264641AbRFUB4E>; Wed, 20 Jun 2001 21:56:04 -0400
Message-ID: <3B31548A.5CD51796@idcomm.com>
Date: Wed, 20 Jun 2001 19:57:30 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <200106202120.f5KLKO5320707@saturn.cs.uml.edu> <0106201412240B.00776@localhost.localdomain> <3B3142DB.F4658CA4@idcomm.com> <0106201618550H.00776@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> On Wednesday 20 June 2001 20:42, D. Stimits wrote:
> > Rob Landley wrote:
> > ...snip...
> >
> > > The patches-linus-actuall-applies mailing list idea is based on how Linus
> > > says he works: he appends patches he likes to a file and then calls patch
> > > -p1 < thatfile after a mail reading session.  It wouldn't be too much
> > > work for somebody to write a toy he could use that lets him work about
> > > the same way but forwards the messages to another folder where they can
> > > go out on an otherwise read-only list.  (No extra work for Linus.  This
> > > is EXTREMELY important, 'cause otherwise he'll never touch it.)
> >
> > What if the file doing patches from is actually visible on a web page?
> > Or better yet, if the patch command itself was modified such that at the
> > same time it applies a patch, the source and the results were added to a
> > MySQL server which in turn shows as a web page?
> 
> His patch file already has a bunch of patches glorped together.  In theory
> they could be separated again by parsing the mail headers.  I suppose that
> would be less work for Linus...
> 
> The point is, the difference between the patches WE get and the patches LINUS
> gets is the granularity.  He's constantly extorting other people to watch the
> granularity of what they send him (small patches, each doing one thing, with
> good documentation as to what they do and why, in seperate messages), but
> what WE get is a great big diff about once a week.

If patch was itself modified, the one big patch file could easily be
considered in terms of all of its smaller patches in any processing it
does as a publication aid.

> 
> So what I'm trying to figure out is if we can impose on Linus to cc: a
> mailing list on the stream of individual patch messages he's applying to his
> tree, so we can follow it better.  And he IS willing to do a LITTLE work for
> us.  He's issuing changelogs now.  This would be significantly less effort
> than that...

The patch command already considers one large file to be a lot of
smaller patches in most cases. Why not, as it does its work, let it
document what it has done?

> 
> MySQL is overkill, and since these things started as mail messages why should
> they be converted into a foriegn format?  There's threaded archivers for
> mailing lists and newsgroups and stuff already, why reinvent the wheel?

MySQL is just a sample. I mention it because it is quite easy to link a
web server to. Imagine patch running on a large file that is a
conglomeration of 50 small patches; it could easily summarize this, and
storing it through MySQL adds a lot of increased web flexibility (such
as searching and sorting). It is, however, just one example of a way to
make "patch" become autodocumenting.

> 
> Rob
