Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbWBNGXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWBNGXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWBNGXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:23:47 -0500
Received: from mail.harddata.com ([216.123.194.198]:48058 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S1030353AbWBNGXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:23:45 -0500
Date: Mon, 13 Feb 2006 23:22:25 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, arjan@infradead.org,
       len.brown@intel.com, davem@davemloft.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, axboe@suse.de,
       James.Bottomley@steeleye.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       luming.yu@intel.com, lk@bencastricum.nl, sanjoy@mrao.cam.ac.uk,
       helgehaf@aitel.hist.no, fluido@fluido.as, gbruchhaeuser@gmx.de,
       Nicolas.Mailhot@LaPoste.net, perex@suse.cz, tiwai@suse.de,
       patrizio.bassi@gmail.com, bni.swe@gmail.com, arvidjaar@mail.ru,
       p_christ@hol.gr, ghrt@dial.kappa.ro, jinhong.hu@gmail.com,
       andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org, bcrl@kvack.org
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060214062225.GA26827@mail.harddata.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D9@hdsmsx401.amr.corp.intel.com> <20060213001240.05e57d42.akpm@osdl.org> <1139821068.2997.22.camel@laptopd505.fenrus.org> <20060214030821.GA23031@mail.harddata.com> <20060213192838.64013c6c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213192838.64013c6c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 07:28:38PM -0800, Andrew Morton wrote:
> Michal Jaegermann <michal@harddata.com> wrote:
> >
> > On Mon, Feb 13, 2006 at 09:57:48AM +0100, Arjan van de Ven wrote:
> > > On Mon, 2006-02-13 at 00:12 -0800, Andrew Morton wrote:
> > > > 
> > > > I think we can assume that it will be seen there.  2.6.16 is going into
> > > > distros and will have more exposure than 2.6.15, 
> > > 
> > > 2.6.15 went into distros as well, such as Fedora Core 4 ;)
> > 
> > And promptly broke laptop suspension.  See, for example:
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=180998
> > 
> 
> That's suspend-to-disk, yes?

No.  That is an S3 suspension to RAM.  On the box in question it
generally worked for quite a long while now provided
'acpi_sleep=s3_bios' was passed to a kernel or video would be
unrestorable.  It is Acer Travelmate 230 with i845G video.

I did not try on that laptop suspend-to-disk so far (and in this
moment the damn thing is just plain broken).

   Michal
