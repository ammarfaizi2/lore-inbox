Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264389AbRFUBUU>; Wed, 20 Jun 2001 21:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264425AbRFUBUK>; Wed, 20 Jun 2001 21:20:10 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:62086 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264389AbRFUBUC>; Wed, 20 Jun 2001 21:20:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "D. Stimits" <stimits@idcomm.com>, linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Wed, 20 Jun 2001 16:18:55 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <200106202120.f5KLKO5320707@saturn.cs.uml.edu> <0106201412240B.00776@localhost.localdomain> <3B3142DB.F4658CA4@idcomm.com>
In-Reply-To: <3B3142DB.F4658CA4@idcomm.com>
MIME-Version: 1.0
Message-Id: <0106201618550H.00776@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 20:42, D. Stimits wrote:
> Rob Landley wrote:
> ...snip...
>
> > The patches-linus-actuall-applies mailing list idea is based on how Linus
> > says he works: he appends patches he likes to a file and then calls patch
> > -p1 < thatfile after a mail reading session.  It wouldn't be too much
> > work for somebody to write a toy he could use that lets him work about
> > the same way but forwards the messages to another folder where they can
> > go out on an otherwise read-only list.  (No extra work for Linus.  This
> > is EXTREMELY important, 'cause otherwise he'll never touch it.)
>
> What if the file doing patches from is actually visible on a web page?
> Or better yet, if the patch command itself was modified such that at the
> same time it applies a patch, the source and the results were added to a
> MySQL server which in turn shows as a web page?

His patch file already has a bunch of patches glorped together.  In theory 
they could be separated again by parsing the mail headers.  I suppose that 
would be less work for Linus...

The point is, the difference between the patches WE get and the patches LINUS 
gets is the granularity.  He's constantly extorting other people to watch the 
granularity of what they send him (small patches, each doing one thing, with 
good documentation as to what they do and why, in seperate messages), but 
what WE get is a great big diff about once a week.

So what I'm trying to figure out is if we can impose on Linus to cc: a 
mailing list on the stream of individual patch messages he's applying to his 
tree, so we can follow it better.  And he IS willing to do a LITTLE work for 
us.  He's issuing changelogs now.  This would be significantly less effort 
than that...

MySQL is overkill, and since these things started as mail messages why should 
they be converted into a foriegn format?  There's threaded archivers for 
mailing lists and newsgroups and stuff already, why reinvent the wheel?

Rob
