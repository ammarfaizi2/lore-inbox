Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWBVQic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWBVQic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWBVQic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:38:32 -0500
Received: from xenotime.net ([66.160.160.81]:24215 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751367AbWBVQib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:38:31 -0500
Date: Wed, 22 Feb 2006 08:38:28 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Matthew Wilcox <matthew@wil.cx>
cc: Douglas Gilbert <dougg@torque.net>,
       Matthias Andree <matthias.andree@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: lsscsi-0.17 released
In-Reply-To: <20060222163426.GG28587@parisc-linux.org>
Message-ID: <Pine.LNX.4.58.0602220835440.8025@shark.he.net>
References: <43FBA4CD.6000505@torque.net> <m34q2r93q2.fsf@merlin.emma.line.org>
 <43FC7CCB.4090508@torque.net> <20060222160602.GB17473@merlin.emma.line.org>
 <43FC90E4.10805@torque.net> <20060222163426.GG28587@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Matthew Wilcox wrote:

> On Wed, Feb 22, 2006 at 11:27:16AM -0500, Douglas Gilbert wrote:
> > Matthias Andree wrote:
> > > On Wed, 22 Feb 2006, Douglas Gilbert wrote:
> > >>Matthias Andree wrote:
> > >>>Does this work around new incompatibilities in the kernel
> > >>>or does this fix lsscsi bugs?
> > >>
> > >>The former. In lk 2.6.16-rc1 the
> > >>/sys/class/scsi_device/<hcil>/device/block symlink
> > >>changed to ".../block:sd<x>" breaking lsscsi 0.16 (and
> > >>earlier) and sg_map26 (in sg3_utils).
> > >
> > > Heck, what was the reason for breaking userspace again?
> >
> > Maybe the person responsible can answer. I'm only reacting
> > to a change that broke two of my utilities.
>
> Probably better to cc the person responsible if you want an answer.
>
> > > Why would someone even consider using sysfs at all if it changes
> > > incompatibly?
> >
> > Indeed.
>
> There seems to be no committment to making sysfs a stable part of the
> kernel API.  Which is really just another way of saying "we can't be
> bothered to design it upfront, we'll just let it evolve into a mess
> and then try to fix it afterwards".

I sorta hate to say this, but I was sitting/working a few feet
from Pat Mochel about 4 years ago when he was beginning on sysfs,
and I told him to watch out, it could end up a mess just like
procfs... :(

-- 
~Randy
