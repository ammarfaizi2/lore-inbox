Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWBUM2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWBUM2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 07:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWBUM2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 07:28:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59841 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751173AbWBUM17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 07:27:59 -0500
Date: Tue, 21 Feb 2006 13:27:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060221122728.GA21807@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602211257.29161.ncunningham@cyclades.com> <200602202319.15018.dtor_core@ameritech.net> <200602211551.12379.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602211551.12379.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 21-02-06 15:51:08, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 21 February 2006 14:19, Dmitry Torokhov wrote:
> > On Monday 20 February 2006 21:57, Nigel Cunningham wrote:
> > > For the record, my thinking went: swsusp uses n (12?) bytes of meta data
> > > for every page you save, where as using bitmaps makes that much closer to
> > > a constant value (a small variable amount for recording where the image
> > > will be stored in extents). 12 bytes per page is 3MB/1GB. If swsusp was
> > > to add support for multiple swap partitions or writing to files, those
> > > requirements might be closer to 5MB/GB.
> >
> > 5MB/GB amounts to 0.5% overhead, I don't think you should be concerned
> > here. Much more important IMHO is that IIRC swsusp requires to be able to
> > free 1/2 of the physical memory whuch is hard on low memory boxes.
> 
> Agreed. I'll look for related issues, and if there are none (or nothing 
> serious), we can have one less difference between the two implementations. I 
> may even be able to share the lowlevel code with Pavel then. That would be a 
> good step forward.

Yep, that would be very nice.
									Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
