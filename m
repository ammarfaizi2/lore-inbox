Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267979AbRG0M5O>; Fri, 27 Jul 2001 08:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268841AbRG0M5E>; Fri, 27 Jul 2001 08:57:04 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:13071 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267979AbRG0M4u>; Fri, 27 Jul 2001 08:56:50 -0400
Message-ID: <3B6164D7.67CB1ED7@namesys.com>
Date: Fri, 27 Jul 2001 16:55:51 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: bvermeul@devel.blackstar.nl
CC: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>, Steve Kieu <haiquy@yahoo.com>,
        Sam Thompson <samuelt@cervantes.dabney.caltech.edu>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107271448510.9291-100000@devel.blackstar.nl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

bvermeul@devel.blackstar.nl wrote:
> 
> On Wed, 18 Jul 2001, Erik Mouw wrote:
> 
> > On Wed, Jul 18, 2001 at 03:18:59PM +1000, Steve Kieu wrote:
> > > My advice:
> > >
> > > Dont use reiserfs,JFS
> > > it is ok to use ext2
> > >
> > > Go journalling? use ext3 or XFS
> > >
> > > I have used  all of these fs and pick up this rule (up
> > > to now, not sure it remains right in the far  future)
> >
> > FUD. I've been using reiserfs on quite some systems and never got any
> > problem. If reiserfs wouldn't be stable, SuSE wouldn't have supported
> > it as one of their stable filesystems for over a year.
> 
> Actually, I've been having some nasty corruption problems as well with
> reiserfs. I develop my own drivers, and do occasionally make a mistake,
> and when that hangs the kernel it will also screw up all files touched
> just before it in a edit-make-install-try cycle. Which can be rather
> annoying, because you can start all over again (this effect randomly
> distributes the last touched sectors to the last touched files. Very nice
> effect, but not something I expect from a journalled filesystem).
> 
> Regards,
> 
> Bas Vermeulen
> 
> --
> "God, root, what is difference?"
>         -- Pitr, User Friendly
> 
> "God is more forgiving."
>         -- Dave Aronson
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Do you think it is reasonable to ask that a filesystem be designed to work well with bad drivers?
