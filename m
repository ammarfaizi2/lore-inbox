Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbRC3Bir>; Thu, 29 Mar 2001 20:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbRC3Bii>; Thu, 29 Mar 2001 20:38:38 -0500
Received: from server1.cosmoslink.net ([208.179.167.101]:46904 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S129719AbRC3BiZ>; Thu, 29 Mar 2001 20:38:25 -0500
Message-ID: <02eb01c0b8ba$3d785ce0$bba6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Jaswinder Singh" <jaswinder.singh@3disystems.com>,
   "Linus Torvalds" <torvalds@transmeta.com>,
   "Jamey Hicks" <jamey@crl.dec.com>, <linux-kernel@vger.kernel.org>
Cc: "Stephen L Johnson" <sjohnson@monsters.org>
In-Reply-To: <024801c0ab59$76350880$bba6b3d0@Toshiba>
Subject: Re: Memory leak in the ramfs file system
Date: Thu, 29 Mar 2001 17:39:19 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-Mimeole: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is some problem in my computer's clock . please do not mind .

I am sorry for inconvenience.

Jaswinder.

----- Original Message -----
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Linus Torvalds" <torvalds@transmeta.com>; "Jamey Hicks"
<jamey@crl.dec.com>; <linux-kernel@vger.kernel.org>
Cc: "Stephen L Johnson" <sjohnson@monsters.org>; "Jaswinder Singh"
<jaswinder.singh@3disystems.com>
Sent: Monday, March 12, 2001 5:03 PM
Subject: Fw: Memory leak in the ramfs file system


> I am sorry, i am sending this mail again because earlier my Computer's
time
> was not set properly.
>
> Jaswinder
>
> ----- Original Message -----
> From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
> To: <linux-kernel@vger.kernel.org>; "Linus Torvalds"
> <torvalds@transmeta.com>; "Jamey Hicks" <jamey@crl.dec.com>
> Cc: "Stephen L Johnson" <sjohnson@monsters.org>; "Jaswinder Singh"
> <jaswinder.singh@3disystems.com>
> Sent: Monday, June 12, 2000 12:50 PM
> Subject: Re: Memory leak in the ramfs file system
>
>
> > Dear Linus,
> >
> >
> > > What does /proc/slabinfo say? The most likely leak is a dentry leak or
> > > an inode leak, and both of those should be fairly easy to see in the
> > > slab info (dentry_cache and inode_cache respectively).
> > >
> >
> > I am attaching details before and during  my application .
> >
> > Mainly changes are in dentry_cache and inode_cache , but i am attaching
> > whole /proc/slabinfo for your reference.
> >
> >
> > > Obviously, it could be a data page leak too, but such a leak should be
> > > easy to see by creating a few big files and deleting them..
> > >
> > > Linus
> >
> > I am also facing one more problem with ramfs.
> >
> > du and df shows 0 , so i am also attaching its output.
> >
> > Thanks for your help,
> >
> > Best Regards,
> >
> > Jaswinder.
> > --
> > These are my opinions not 3Di.
> >
> >
> >
> >
>

