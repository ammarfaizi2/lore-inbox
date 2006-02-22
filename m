Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWBVQe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWBVQe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWBVQe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:34:29 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:19944 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751370AbWBVQe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:34:28 -0500
Date: Wed, 22 Feb 2006 09:34:26 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Douglas Gilbert <dougg@torque.net>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: lsscsi-0.17 released
Message-ID: <20060222163426.GG28587@parisc-linux.org>
References: <43FBA4CD.6000505@torque.net> <m34q2r93q2.fsf@merlin.emma.line.org> <43FC7CCB.4090508@torque.net> <20060222160602.GB17473@merlin.emma.line.org> <43FC90E4.10805@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC90E4.10805@torque.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:27:16AM -0500, Douglas Gilbert wrote:
> Matthias Andree wrote:
> > On Wed, 22 Feb 2006, Douglas Gilbert wrote: 
> >>Matthias Andree wrote:
> >>>Does this work around new incompatibilities in the kernel
> >>>or does this fix lsscsi bugs?
> >>
> >>The former. In lk 2.6.16-rc1 the
> >>/sys/class/scsi_device/<hcil>/device/block symlink
> >>changed to ".../block:sd<x>" breaking lsscsi 0.16 (and
> >>earlier) and sg_map26 (in sg3_utils).
> > 
> > Heck, what was the reason for breaking userspace again?
> 
> Maybe the person responsible can answer. I'm only reacting
> to a change that broke two of my utilities.

Probably better to cc the person responsible if you want an answer.

> > Why would someone even consider using sysfs at all if it changes
> > incompatibly?
> 
> Indeed.

There seems to be no committment to making sysfs a stable part of the
kernel API.  Which is really just another way of saying "we can't be
bothered to design it upfront, we'll just let it evolve into a mess
and then try to fix it afterwards".
