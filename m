Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265317AbUGVNRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUGVNRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 09:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265429AbUGVNRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 09:17:55 -0400
Received: from imap.gmx.net ([213.165.64.20]:2210 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265317AbUGVNRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 09:17:52 -0400
Date: Thu, 22 Jul 2004 15:17:51 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "lkml " <linux-kernel@vger.kernel.org>
Cc: kernel@mandrakesoft.com, nplanel@mandrakesoft.com, tmb@mandrake.org
MIME-Version: 1.0
Subject: Re: New dev model (was [PATCH] delete devfs)
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <14610.1090502271@www50.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

once again, sorry for this way of replying,
could you keep me CC'd as i'm not subscribed to lkml

-----------start of original message --------------
On Thu, 2004-07-22 at 05:19, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > On Thu, Jul 22, 2004 at 02:55:39AM -0700, Andrew Morton wrote:
> > > Adrian Bunk <bunk@fs.tum.de> wrote:
> > > >
> > > > Changes that remove functionally like Greg's patch are hopefully 
> > > > still 2.7 stuff - 2.6 is a stable kernel series and smooth upgrades 
> > > > inside a stable kernel series are a must for many users.
> > > 
> > > I don't necessarily agree that such changes in the userspace interface
> > > should be tied to the kernel version number, really.  That's a three
or
> > > four year warning period, which is unreasonably long.  Six to twelve
months
> > > should be long enough for udev-based replacements to stabilise and
> > > propagate out into distributions.
> > 
> > Users have had the 6-12 month warning about devfs for a while now :)
> 
> No, they had a three year warning.  "It'll be gone in 2.8".
> 
> > Ok, if people think that would really change anything, I'll wait a year.
> > I'm patient :)
> 
> Delete 100 lines per week ;)

That could be done by sending in smaller patches that remove devfs calls
from drivers.  If nothing in the kernel is using devfs, then there is no
reason to keep it around anymore...

Just a thought.

josh

-----------end of original message --------------

please don't do it /*at least not in the following two months :-)*/

what does this buy us ?

once again about the upcoming Mandrake 10.1,
we already have readded devfs support to isdn,
should we start tracking bk-head for such patches
that remove devfs support from drivers
and revert them ? 
should we stay with 2.6.7 (or eventually 2.6.8)?
there is really no time to integarate/test udev
as replacement of devfs for the next release.

best,

svetljo

-- 
+++ GMX DSL-Tarife 3 Monate gratis* +++ Nur bis 25.7.2004 +++
Bis 24.000 MB oder 300 Freistunden inkl. http://www.gmx.net/de/go/dsl

