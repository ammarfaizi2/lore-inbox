Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUGVM6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUGVM6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 08:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUGVM6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 08:58:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30859 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265199AbUGVM6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 08:58:14 -0400
Subject: Re: New dev model (was [PATCH] delete devfs)
From: Josh Boyer <jdub@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, bunk@fs.tum.de, corbet@lwn.net,
       bgerst@didntduck.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040722031923.654258e3.akpm@osdl.org>
References: <40FEEEBC.7080104@quark.didntduck.org>
	 <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de>
	 <20040722025539.5d35c4cb.akpm@osdl.org> <20040722070453.GA21907@kroah.com>
	 <20040722031923.654258e3.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1090500939.13986.32.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 22 Jul 2004 07:55:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
> > > should be tied to the kernel version number, really.  That's a three or
> > > four year warning period, which is unreasonably long.  Six to twelve months
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

