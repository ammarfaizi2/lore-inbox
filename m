Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131228AbRBDBo0>; Sat, 3 Feb 2001 20:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131251AbRBDBoQ>; Sat, 3 Feb 2001 20:44:16 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:43247 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S131228AbRBDBoC>;
	Sat, 3 Feb 2001 20:44:02 -0500
Message-Id: <5.0.2.1.2.20010204012431.00a7b9a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 04 Feb 2001 01:43:54 +0000
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [ANNOUNCE] Linux-NTFS project, first public release
Cc: lists@frednet.dyndns.org, linux-kernel@vger.kernel.org,
        dneault@microsoft.com
In-Reply-To: <20010203190231.A8840@vger.timpanogas.org>
In-Reply-To: <5.0.2.1.2.20010204002341.00a90cc0@pop.cus.cam.ac.uk>
 <20010203181433.A2882@frednet.dyndns.org>
 <5.0.2.1.2.20010203184941.00a95ae0@pop.cus.cam.ac.uk>
 <20010203181433.A2882@frednet.dyndns.org>
 <20010203181617.B8621@vger.timpanogas.org>
 <5.0.2.1.2.20010204002341.00a90cc0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:02 04/02/2001, Jeff V. Merkey wrote:
>On Sun, Feb 04, 2001 at 12:37:16AM +0000, Anton Altaparmakov wrote:
>I am noticeable impressed with your ability to address these issues.

(-:

>Microsoft would be much happier I am certain with a pure Linux solution
>for this problem.  They have been incredibly tolerant in allowing

Believe me, so would I! It's a long way to go to having a fully functional 
ntfsck Linux utility, but we will get there eventually. And of course, the 
actual driver is under heavy development both by Yuri Per of Acronis Ltd. 
and myself at the moment (he is probably doing more than me as he does this 
as part of a full time job...). In fact I am sitting on a very nice patch 
for the driver at the moment but want to do some testing before I send it 
off to Alan as it does quite a lot of fixing including a nasty race I found 
staring at the code yesterday and several bug fixes and clean ups (or 
rather rewrites of some functions almost) courtesy of Yuri. So the 
importance of ntfsfix should become smaller and smaller as time goes on 
until eventually we won't need it all. (-:

>me to help customers with trashed drives, but I am sure you are
>aware that they were only tolerating it since it was helping
>customers who use both NT and Linux, and even this was quite
>a stretch they did not have to go.   It's a statement that even in
>those cases where tey may be helping Linux, they put their customers
>needs first (this took some convincing on my part).

Yes, I am aware of that. I very much doubt that Microsoft would be helping 
Linux without an extremely good reason. I guess the only way part of 
Microsoft might start working with/on Linux would be if the DOJ would split 
the company up in two parts OS/Servers and Office apps. If that would 
happen the Office part would have a growing market interest in a Linux 
port, which at the moment is out of the question as Office is probably one 
of the last barriers to a mass user migration to Linux. - Imagine all the 
office and home environments where Windows is used solely for the purpose 
of using Microsoft Word/Excel. They could all switch to Linux and many 
would probably do so if Word/Excel would exist under Linux... It would be 
very cost effective, too. - Oh well, one can dream. (-;

>They are very angry at me right now for even doing this in the
>first place, and I doubt the relationship will ever be back on
>the keel it was originally, but since I work on Linux almost
>exslusively now, I do not think it matters.

While it doesn't matter, I am sure things will improve over time.

>Good Work, A++.

Thanks! (-:

Best regards,

         Anton

> > At 01:16 04/02/2001, Jeff V. Merkey wrote:
> > >To date, I have provided tools to 7,000+ folks who use this driver that
> > >trash their NTFS partitions.  TRG will discontinue distribution of these
> > >tools at this point since Anton has a Linux based version.
> > >
> > >Please do not email me for any more NT based repair tools for damaged
> > >NTFS partitions trashed by Linux.  Please contact Andre and use his
> >
> > You probably meant Anton in the sentence above...
> >
> > >tools instead.  I will inform Microsoft I will no longer be providing
> > >these tools since Anton now has something that will do the job.
> >
> > The NTFS disk edit utility you were providing does quite a lot more since
> > it is interactive. And my utility doesn't do everything I would like it to
> > do yet but it does work so I wanted to push a release out of the door 
> ASAP.
> > But it doesn't really matter. The NTFS disk editor is a relatively freely
> > available utility as I found out recently, anyways. It is present on the
> > Windows NT4 Service Pack 4 CD! It's not mentioned anywhere in the
> > documentation but it sure is there among the service pack files. I managed
> > to dig the out in our College computer office and it's now officially 
> mine.
> > That has the advantage of not binding you to the license of only using it
> > for repairing NTFS partitions... (-:
> >
> > Best regards,
> >
> > Anton
> >
> >
> > --
> > Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> > Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
> > ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
