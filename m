Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135802AbRDTFLS>; Fri, 20 Apr 2001 01:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135803AbRDTFLH>; Fri, 20 Apr 2001 01:11:07 -0400
Received: from nic-25-c96-008.mn.mediaone.net ([24.25.96.8]:62731 "EHLO
	lupo.thebarn.com") by vger.kernel.org with ESMTP id <S135802AbRDTFLE>;
	Fri, 20 Apr 2001 01:11:04 -0400
Message-ID: <3ADFC3D1.BF4176A5@thebarn.com>
Date: Fri, 20 Apr 2001 00:06:26 -0500
From: Russell Cattelan <cattelan@thebarn.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.12 i386)
X-Accept-Language: en
MIME-Version: 1.0
To: james rich <james.rich@m.cc.utah.edu>
CC: linux-xfs@oss.sgi.com
Subject: Re: kernel merge issues
In-Reply-To: <Pine.GSO.4.05.10104192208340.8316-100000@pipt.oz.cc.utah.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james rich wrote:

> Hi folks,
>         I'm sure many here have read the discussion on lkml about lvm and
> the problems that team is having.  As part of that discussion it was said:

I'm not entirely familiar with the issues surrounding lvm development, I know
things
are not in good shape right now.

But I would say the following statement is unrealistic.
Trying to manage a large software project without source code control is
an even bigger nightmare than with source code control.
patch is NOT a source code control tool.
In fact a good source code control system would allow patch incremental
generation,
This is actually one glaring limitation of CVS, the ability group a set of
changes
together, aka "mod"
(Bitkeeper has addressed a lot of these issues; it can generate or accept
incremental
patch sets)

The lvm problems seems to be more of wetware issue than a source code
control tool issue.

Hopefully XFS will be able to keep ahead the problem of dramatically
diverging
code bases by staying active with Linus's releases.

> Dan Kegel <dank@kegel.com>:
> >I know very little about LVM, but from watching earlier projects
> >in the same situation you're in now, the path you need to follow
> >seems clear:
> >   Stop using CVS internally for development.
> >   It makes checking in changes without submitting them to
> >   Linus too easy.
>
> >To get sync'd back up, *start with the standard kernel*,
> >and start generating clean, human-understandable patches one
> >at a time that bring it up to where you want.
>
> I am wondering how the XFS team plans on avoiding the same problems once
> XFS becomes part of the kernel.  Is there potential for problems with SGI
> "losing control" over the source or direction of XFS once Linus puts it in
> his tree?
>
> How does the above comment relate to the XFS team's plans on patches to
> XFS and related areas once XFS is in?
>
> Just want to get these issues into the air before rancor and ill will
> spread...
>
> P.S. XFS has been extremely solid and has saved me a lot of time waiting
> for fscks.  I am really impressed by the professionalism of the XFS team.
> Hopefully I can contribute soon - working on a slackware boot/modules/root
> disk set for XFS.
>
> James Rich
> james.rich@m.cc.utah.edu

