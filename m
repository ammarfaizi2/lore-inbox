Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132121AbRCYRIu>; Sun, 25 Mar 2001 12:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132122AbRCYRIk>; Sun, 25 Mar 2001 12:08:40 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:56202 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132121AbRCYRI2>; Sun, 25 Mar 2001 12:08:28 -0500
Message-Id: <5.0.2.1.2.20010325180537.04690940@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 25 Mar 2001 18:07:17 +0100
To: "Michel Wilson" <michel@procyon14.yi.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: RE: Larger dev_t
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <NEBBLEJBILPLHPBNEEHIEEPNCAAA.michel@procyon14.yi.org>
In-Reply-To: <20010325081524.E30469@sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:54 25/03/2001, Michel Wilson wrote:
> > Wichert Akkerman wrote:
> > > You are just delaying the problem then, at some point your uptime will
> > > be large enough that you have run through all 64bit pids for example.
> >
> > 64 bits is enough to fork 1 million processes per second for over
> > 500,000 years.  I think that's putting the problem off far enough.
> >
> > -Mitch
> > -
>Ever thought about how you would kill a process: kill -9 127892752 doesn't
>sound very appealing to me.
>So you'd also need to implement a mechanism that allows for 'easy' selection
>of processes to kill, for example giving every process with the same name
>a unique identifier (like httpd_0, httpd_1, httpd_2 and so on).

Ever heard of cut-and-paste? Surely you can afford a mouse... And for when 
you you are not inputting manually but running a script/whatever, who cares 
what the numbers are...

Cheers,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

